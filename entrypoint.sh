#!/bin/bash

# Запуск тестов Playwright
npx playwright test --reporter=allure-playwright

# Генерация Allure-отчета
npx allure generate allure-results --clean -o allure-report

# Генерация скриншота Allure-отчета
apt-get update && apt-get install -y wkhtmltopdf
xvfb-run --server-args="-screen 0, 1920x1080x24" \
    wkhtmltoimage --width 1024 --quality 80 \
    http://127.0.0.1:8080 allure-report/screenshot.png

# Запуск локального сервера для Allure
npx http-server allure-report -p 8080 &
sleep 5 # Ждем, пока сервер запустится

# Отправка скриншота в Telegram
curl -F chat_id="${TELEGRAM_CHAT_ID}" \
     -F photo="@allure-report/screenshot.png" \
     -F caption="Allure Report Screenshot" \
     "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendPhoto"

# Завершение работы сервера
kill %1
