-- Update email domain enforcement to allow both keysight.com and jonathon.ai
CREATE OR REPLACE FUNCTION public.enforce_email_domain()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  IF NEW.email IS NULL OR (
    lower(NEW.email) NOT LIKE '%@keysight.com'
    AND lower(NEW.email) NOT LIKE '%@jonathon.ai'
  ) THEN
    RAISE EXCEPTION 'Only @keysight.com or @jonathon.ai email addresses are allowed to register.';
  END IF;
  RETURN NEW;
END;
$function$;

-- Update team membership check to recognize both domains
CREATE OR REPLACE FUNCTION public.is_team_member(_user_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE user_id = _user_id
      AND (
        lower(email) LIKE '%@keysight.com'
        OR lower(email) LIKE '%@jonathon.ai'
      )
  );
$function$;