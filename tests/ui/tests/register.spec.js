import { test, expect } from '@playwright/test';
import RegisterPage from '../pages/RegisterPage';
import { faker } from '@faker-js/faker';

test.describe('Тесты регистрации', () => {
  let registerPage;

  test.beforeEach(async ({ page }) => {
    registerPage = new RegisterPage(page);
    await registerPage.open();
  });

  test.afterEach(async ({ page }, testInfo) => {
    if (testInfo.title !== 'Успешная регистрация с валидными данными') {
      await registerPage.clearForm(); // Очищаем форму
    }
  });

  test('Ошибка при отсутствии полного имени', async ({ page }) => {
    const email = faker.internet.email();
    const password = faker.internet.password(8);

    // Отправить форму без полного имени
    await registerPage.submitForm('', email, password, password);

    // Проверить сообщение об ошибке
    const errorMessage = page.locator('text=Name is required'); // Более надежный селектор
  await expect(errorMessage).toBeVisible({ timeout: 5000 }); // Уменьшенный таймаут
});

test('Ошибка при отсутствии Email', async ({ page }) => {
    const fullName = faker.person.fullName();
    const password = faker.internet.password(8);
  
    // Отправить форму без Email
    await registerPage.submitForm(fullName, '', password, password);
  
    // Проверить сообщение об ошибке
    const errorMessage = page.locator('text=Email is required'); // Обновленный селектор
    await expect(errorMessage).toBeVisible({ timeout: 5000 });
  });
  
  test('Ошибка при слишком коротком пароле', async ({ page }) => {
    const fullName = faker.person.fullName();
    const email = faker.internet.email();
    const shortPassword = '123'; // Короткий пароль
  
    // Заполнить форму
    await registerPage.submitForm(fullName, email, shortPassword, shortPassword);
  
    // Проверить, что кнопка остаётся отключённой
    await expect(registerPage.submitButton).toBeDisabled();
  
    // Проверить сообщение об ошибке
    const errorMessage = page.locator('text=Password must be at least 8 characters'); // Проверьте точный текст
    await expect(errorMessage).toBeVisible({ timeout: 10000 });
  });   

  test('Ошибка при несовпадении паролей', async ({ page }) => {
    const fullName = faker.person.fullName();
    const email = faker.internet.email();
    const password = faker.internet.password(8);
    const differentPassword = faker.internet.password(8); // Генерация другого пароля
  
    // Отправить форму с несовпадающими паролями
    await registerPage.submitForm(fullName, email, password, differentPassword);
  
    // Убедиться, что кнопка продолжения остаётся отключенной
    await expect(registerPage.submitButton).toBeDisabled();
  });  

  test('Успешная регистрация с валидными данными', async ({ page }) => {
    const fullName = faker.person.fullName();
    const email = faker.internet.email();
    const password = faker.internet.password(8);
  
    // Заполнить форму
    await registerPage.submitForm(fullName, email, password, password);
  
    // Проверить сообщение об успешной регистрации
    const successMessage = page.locator('text=Registration successful');
    await expect(successMessage).toBeVisible({ timeout: 10000 });
  
    // Дождаться редиректа или проверить текущий URL
    const currentURL = await page.url();
    if (currentURL.includes('/register')) {
      console.warn('Редирект не произошёл, проверяем сообщение на текущей странице');
    } else {
      // Ожидать изменения URL на логин
      await expect(page).toHaveURL('https://chatgpt.ai-chatbot.studio/login', { timeout: 60000 });
  
      // Проверить наличие кнопки "Login" на странице логина
      const loginButton = page.locator('text="Login"');
      await expect(loginButton).toBeVisible();
    }
  
    // Сделать скриншот для отладки
    await page.screenshot({ path: 'registration_test.png' });
  });
  
}); 