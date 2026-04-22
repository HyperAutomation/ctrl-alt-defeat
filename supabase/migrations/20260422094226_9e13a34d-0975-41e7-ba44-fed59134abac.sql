
-- Profiles table
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  display_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Categories table
CREATE TABLE public.categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  created_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

-- Files table
CREATE TABLE public.files (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  storage_path TEXT NOT NULL UNIQUE,
  size_bytes BIGINT NOT NULL DEFAULT 0,
  mime_type TEXT,
  category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
  uploaded_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.files ENABLE ROW LEVEL SECURITY;
CREATE INDEX idx_files_category ON public.files(category_id);
CREATE INDEX idx_files_uploaded_by ON public.files(uploaded_by);

-- Share links table (for public share URLs)
CREATE TABLE public.share_links (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  file_id UUID NOT NULL REFERENCES public.files(id) ON DELETE CASCADE,
  token TEXT NOT NULL UNIQUE,
  expires_at TIMESTAMPTZ,
  created_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.share_links ENABLE ROW LEVEL SECURITY;
CREATE INDEX idx_share_links_token ON public.share_links(token);

-- Updated_at trigger function
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_files_updated_at
  BEFORE UPDATE ON public.files
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Domain-restricted signup: only @keysight.com allowed
CREATE OR REPLACE FUNCTION public.enforce_email_domain()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.email IS NULL OR lower(NEW.email) NOT LIKE '%@keysight.com' THEN
    RAISE EXCEPTION 'Only @keysight.com email addresses are allowed to register.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER enforce_email_domain_trigger
  BEFORE INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.enforce_email_domain();

-- Auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (user_id, email, display_name)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Helper: is current user a verified team member?
CREATE OR REPLACE FUNCTION public.is_team_member(_user_id UUID)
RETURNS BOOLEAN
LANGUAGE SQL STABLE SECURITY DEFINER SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE user_id = _user_id AND lower(email) LIKE '%@keysight.com'
  );
$$;

-- RLS: profiles
CREATE POLICY "Team members view all profiles"
  ON public.profiles FOR SELECT TO authenticated
  USING (public.is_team_member(auth.uid()));

CREATE POLICY "Users update own profile"
  ON public.profiles FOR UPDATE TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own profile"
  ON public.profiles FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- RLS: categories
CREATE POLICY "Team members view categories"
  ON public.categories FOR SELECT TO authenticated
  USING (public.is_team_member(auth.uid()));

CREATE POLICY "Team members create categories"
  ON public.categories FOR INSERT TO authenticated
  WITH CHECK (public.is_team_member(auth.uid()) AND auth.uid() = created_by);

CREATE POLICY "Creator deletes own category"
  ON public.categories FOR DELETE TO authenticated
  USING (auth.uid() = created_by);

-- RLS: files
CREATE POLICY "Team members view files"
  ON public.files FOR SELECT TO authenticated
  USING (public.is_team_member(auth.uid()));

CREATE POLICY "Team members upload files"
  ON public.files FOR INSERT TO authenticated
  WITH CHECK (public.is_team_member(auth.uid()) AND auth.uid() = uploaded_by);

CREATE POLICY "Owner updates own file"
  ON public.files FOR UPDATE TO authenticated
  USING (auth.uid() = uploaded_by);

CREATE POLICY "Owner deletes own file"
  ON public.files FOR DELETE TO authenticated
  USING (auth.uid() = uploaded_by);

-- RLS: share_links
CREATE POLICY "Team members view share links"
  ON public.share_links FOR SELECT TO authenticated
  USING (public.is_team_member(auth.uid()));

CREATE POLICY "Public can resolve share token"
  ON public.share_links FOR SELECT TO anon
  USING (expires_at IS NULL OR expires_at > now());

CREATE POLICY "File owner creates share link"
  ON public.share_links FOR INSERT TO authenticated
  WITH CHECK (
    auth.uid() = created_by AND
    EXISTS (SELECT 1 FROM public.files f WHERE f.id = file_id AND f.uploaded_by = auth.uid())
  );

CREATE POLICY "Creator deletes own share link"
  ON public.share_links FOR DELETE TO authenticated
  USING (auth.uid() = created_by);

-- Storage bucket (private)
INSERT INTO storage.buckets (id, name, public) VALUES ('team-files', 'team-files', false);

-- Storage RLS
CREATE POLICY "Team members read team files"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'team-files' AND public.is_team_member(auth.uid()));

CREATE POLICY "Team members upload team files"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'team-files' AND public.is_team_member(auth.uid()));

CREATE POLICY "Owner deletes own team file"
  ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'team-files' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "Owner updates own team file"
  ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'team-files' AND auth.uid()::text = (storage.foldername(name))[1]);
