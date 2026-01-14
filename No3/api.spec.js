const { test, expect } = require("@playwright/test");

const BASE_URL = "https://reqres.in/api";
const USER_ID_12 = 12;
const USER_ID_1234 = 1234;
const API_KEY = "reqres-free-v1";

const defaultHeaders = {
  "x-api-key": API_KEY,
};

test.describe("REST API GET request testing using reqres.in", () => {
  test("Get User Profile Success", async ({ request }) => {
    const response = await request.get(`${BASE_URL}/users/${USER_ID_12}`, {
      headers: defaultHeaders,
    });

    expect(response.status()).toBe(200);

    const body = await response.json();
    const data = body.data;

    await expect(data.id).toBe(USER_ID_12);
    await expect(data.email).toBe("rachel.howell@reqres.in");
    await expect(data.first_name).toBe("Rachel");
    await expect(data.last_name).toBe("Howell");
    await expect(data.avatar).toBe("https://reqres.in/img/faces/12-image.jpg");
  });

  test("Get User Profile But User Not Found", async ({ request }) => {
    const response = await request.get(`${BASE_URL}/users/${USER_ID_1234}`, {
      headers: defaultHeaders,
    });

    const status = response.status();

    const isError = status === 404 || status === 401;
    expect(isError).toBeTruthy();

    if (status === 404) {
      const body = await response.json();
      expect(Object.keys(body).length).toBe(0);
    }
  });
});
