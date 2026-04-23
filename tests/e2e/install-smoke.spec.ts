import { expect, test } from "@playwright/test";

test.use({ baseURL: "about:blank" });

test("playwright + chromium are installed", async ({ page }) => {
  await page.setContent("<h1>hello from playwright</h1>");
  await expect(page.locator("h1")).toHaveText("hello from playwright");
});
