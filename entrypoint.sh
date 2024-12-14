#!/bin/bash

# Запуск тестов Playwright
npx playwright test --reporter=allure-playwright

# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report

# Установка wkhtmltopdf для конвертации HTML в изображение
apt-get update && apt-get install -y wkhtmltopdf

# Конвертация Allure-отчета в изображение (первую страницу отчета)
wkhtmltoimage --width 800 allure-report/index.html allure-report/report.png

# Отправка изображения в Telegram
curl -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendPhoto" \
     -F chat_id="${TELEGRAM_CHAT_ID}" \
     -F photo="@allure-report/report.png" \
     -F caption="Allure Report with Test Results"
