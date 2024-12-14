import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests', // Директория с тестами
  timeout: 30000, // Таймаут для каждого теста
  expect: {
    timeout: 5000, // Таймаут для ожиданий
  },
  retries: 2, // Добавьте несколько повторных запусков тестов
  reporter: [
    ['allure-playwright'], // Подключение Allure как репортера
    ['html', { open: 'never' }], // HTML отчет (можно использовать для локального просмотра)
    ['list'], // Логирование в консоль
  ],
  use: {
    headless: true, // Запуск тестов в headless режиме
    viewport: { width: 1280, height: 720 }, // Размер экрана браузера
    ignoreHTTPSErrors: true, // Игнорирование ошибок HTTPS
    screenshot: 'only-on-failure', // Делать скриншоты только при падении тестов
    trace: 'retain-on-failure', // Сохранять трассировку только при падении
    video: 'retain-on-failure', // Записывать видео только при падении тестов
    baseURL: process.env.BASE_URL || 'http://localhost:3000', // Добавьте базовый URL
    actionTimeout: 10000, // Таймаут для пользовательских действий
    navigationTimeout: 15000, // Таймаут для навигации
  },
  projects: [
    {
      name: 'Chromium',
      use: { browserName: 'chromium' },
    },
    {
      name: 'Firefox',
      use: { browserName: 'firefox' },
    },
    {
      name: 'Webkit',
      use: { browserName: 'webkit' },
    },
  ],
  outputDir: 'test-results/', // Папка для хранения результатов тестов
});
