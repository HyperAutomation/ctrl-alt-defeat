import { expect, test } from "@playwright/test";

test("landing page renders hero and nav", async ({ page }) => {
  await page.goto("/");
  await expect(page).toHaveTitle(/CTRL-ALT-DEFEAT/i);
  await expect(page.getByRole("heading", { name: /WE TEST/i })).toBeVisible();
});
