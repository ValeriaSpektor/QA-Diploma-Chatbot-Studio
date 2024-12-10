import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests', // Директория с тестами
  timeout: 30000,
  expect: {
    timeout: 5000,
  },
  retries: 0, // Количество повторных запусков тестов в случае их падения
  reporter: [
    ['allure-playwright'], // Подключение Allure как репортера
    ['html', { open: 'never' }] // HTML отчет (можно использовать для локального просмотра)
  ],
  use: {
    headless: true, // Запуск тестов в headless режиме (можно изменить на false для отладки)
    viewport: { width: 1280, height: 720 }, // Размер экрана браузера
    ignoreHTTPSErrors: true, // Игнорирование ошибок HTTPS
    screenshot: 'only-on-failure', // Делать скриншоты только при падении тестов
    video: 'retain-on-failure', // Записывать видео только при падении тестов
  },
});
