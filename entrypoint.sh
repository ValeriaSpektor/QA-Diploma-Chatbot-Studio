#!/bin/bash

# Запуск тестов Playwright
echo "Running Playwright tests..."
npx playwright test --reporter=allure-playwright

# Генерация Allure отчета
echo "Generating Allure report..."
npx allure generate allure-results --clean -o allure-report

# Отправка уведомления в Telegram (если требуется)
if [ ! -z "$TELEGRAM_BOT_TOKEN" ] && [ ! -z "$TELEGRAM_CHAT_ID" ]; then
  echo "Sending Telegram notification..."
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
       -d chat_id=$TELEGRAM_CHAT_ID \
       -d text="Playwright tests completed. Allure report generated."
else
  echo "Telegram notification skipped (missing credentials)."
fi
