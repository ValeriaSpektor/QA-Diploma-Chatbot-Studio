#!/bin/bash

# Запуск тестов Playwright
echo "Running Playwright tests..."
npx playwright test --reporter=allure-playwright

# Генерация Allure отчета
echo "Generating Allure report..."
npx allure generate allure-results --clean -o allure-report

# Создание скриншота отчета
echo "Generating screenshot of Allure report..."
apt-get update && apt-get install -y xvfb wkhtmltopdf
xvfb-run wkhtmltoimage --width 1920 --height 1080 http://localhost:4000/index.html allure-report.png

# Проверка наличия Telegram токена и ID чата
if [ ! -z "$TELEGRAM_BOT_TOKEN" ] && [ ! -z "$TELEGRAM_CHAT_ID" ]; then
  echo "Sending Telegram notification with screenshot..."
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendPhoto" \
       -F chat_id=$TELEGRAM_CHAT_ID \
       -F photo="@allure-report.png" \
       -F caption="Playwright tests completed. Allure report screenshot attached."
else
  echo "Telegram notification skipped (missing credentials)."
fi
