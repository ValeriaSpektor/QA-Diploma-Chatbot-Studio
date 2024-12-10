import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';

test.describe('Тесты логина', () => {
  let loginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    await page.goto('https://chatgpt.ai-chatbot.studio/login'); // Проверьте доступность URL
  });

  // Negative Tests
  test('Ошибка при незаполненном email', async ({ page }) => {
    await loginPage.login('', 'validpassword');
    
    // Проверяем, что поле email подсвечено как неверное
    const emailError = page.locator('input#email[aria-invalid="true"]');
    await expect(emailError).toBeVisible({ timeout: 10000 });
  });

  test('Ошибка при незаполненных полях', async ({ page }) => {
    await loginPage.login('', '');
    
    // Проверяем, что оба поля подсвечены как неверные
    const emailError = page.locator('input#email[aria-invalid="true"]');
    const passwordError = page.locator('input#password[aria-invalid="true"]');
    await expect(emailError).toBeVisible({ timeout: 10000 });
    await expect(passwordError).toBeVisible({ timeout: 10000 });
  });

  // Тест: Успешный вход с валидными данными
  test('Успешный вход с валидными данными', async () => {
    await loginPage.login('new.user@mail.ru', '542073vl');

    // Проверяем редирект после успешного входа
    await expect(loginPage.page).toHaveURL(/\/c\/new/, { timeout: 20000 });
  });
});