import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests', // Директория с тестами
  timeout: 30000, // Таймаут для каждого теста
  expect: {
    timeout: 5000, // Таймаут для ожиданий
  },
  retries: 0, // Количество повторных запусков тестов в случае их падения
  reporter: [
    ['allure-playwright'], // Подключение Allure как репортера
    ['html', { open: 'never' }], // HTML отчет (можно использовать для локального просмотра)
    ['list'], // Логирование в консоль
  ],
  use: {
    headless: true, // Запуск тестов в headless режиме
    viewport: { width: 1280, height: 720 }, // Размер экрана браузера
    ignoreHTTPSErrors: true, // Игнорирование ошибок HTTPS
    screenshot: 'on', // Делать скриншоты для каждого шага
    trace: 'on', // Включить сбор трасс
    video: 'retain-on-failure', // Записывать видео только при падении тестов
    browserName: 'chromium', // Установить браузер Chromium
  },
});
