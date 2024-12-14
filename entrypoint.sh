#!/bin/bash

# Проверяем, существует ли файл telegram.json
echo "Checking if telegram.json exists..."
if [ -f "/app/notifications/telegram.json" ]; then
  echo "telegram.json found:"
  cat /app/notifications/telegram.json
else
  echo "telegram.json NOT found!"
  exit 1
fi

# Запускаем тесты Playwright
echo "Running Playwright tests..."
npx playwright test --reporter=allure-playwright
if [ $? -ne 0 ]; then
  echo "Playwright tests failed!"
  exit 1
fi

# Генерируем Allure-отчет
echo "Generating Allure report..."
allure generate allure-results --clean -o allure-report
if [ $? -ne 0 ]; then
  echo "Failed to generate Allure report!"
  exit 1
fi

# Отправляем уведомление в Telegram через Allure Notifications
echo "Sending Telegram notification..."
java -jar /app/allure-notifications-4.8.0.jar --config /app/notifications/telegram.json
if [ $? -ne 0 ]; then
  echo "Failed to send Telegram notification!"
  exit 1
fi

echo "All tasks completed successfully!"
