#!/bin/bash

set -e  # Завершить выполнение, если какая-либо команда завершится с ошибкой

echo "Запуск Playwright тестов..."
npx playwright test --reporter=allure-playwright

echo "Генерация Allure отчета..."
allure generate allure-results --clean -o allure-report

if [ -f "/app/telegram.json" ]; then
  echo "Отправка уведомления в Telegram..."
  java -jar /app/allure-notifications-4.8.0.jar -DconfigFile=/app/telegram.json
else
  echo "Файл telegram.json не найден. Уведомление не отправлено."
  exit 1
fi

echo "Скрипт завершен успешно."
