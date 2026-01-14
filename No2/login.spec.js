const { test, expect } = require("@playwright/test");

const LOGIN_URL = "http://the-internet.herokuapp.com/login";
const CORRECT_USERNAME = "tomsmith";
const CORRECT_PASSWORD = "SuperSecretPassword!";
const WRONG_PASSWORD = "Password!";
const INVALID_USERNAME = "tomholland";

test.beforeEach(async ({ page }) => {
  await page.goto(LOGIN_URL);
});

async function submitLogin(page, username, password) {
  await page.fill("#username", username);
  await page.fill("#password", password);
  await page.click('button[type="submit"]');
}

function flashLocator(page) {
  return page.locator("#flash");
}

test.describe("Login - Positive Scenarios", () => {
  test("Login Success - valid username and password", async ({ page }) => {
    await expect(page.locator("h2")).toHaveText("Login Page");

    await submitLogin(page, CORRECT_USERNAME, CORRECT_PASSWORD);
    await expect(flashLocator(page)).toContainText(
      "You logged into a secure area!"
    );

    await page.getByRole("link", { name: "Logout" }).click();
    await expect(flashLocator(page)).toContainText(
      "You logged out of the secure area!"
    );
    await expect(page.locator("h2")).toHaveText("Login Page");
  });
});

test.describe("Login - Negative Scenarios", () => {
  test("Login Failed - Password Incorrect", async ({ page }) => {
    await expect(page.locator("h2")).toHaveText("Login Page");
    await submitLogin(page, CORRECT_USERNAME, WRONG_PASSWORD);
    await expect(flashLocator(page)).toContainText("Your password is invalid!");
  });

  test("Login Failed - Username Not Found", async ({ page }) => {
    await expect(page.locator("h2")).toHaveText("Login Page");
    await submitLogin(page, INVALID_USERNAME, WRONG_PASSWORD);
    await expect(flashLocator(page)).toContainText("Your username is invalid!");
  });
});
