#!/bin/bash

# Проверяем, что конфигурационный файл существует
if [ ! -f "/app/notifications/telegram.json" ]; then
    echo "Configuration file /app/notifications/telegram.json not found!"
    exit 1
fi

# Показываем содержимое файла конфигурации для проверки
echo "Checking telegram.json content..."
cat /app/notifications/telegram.json

# Запускаем тесты Playwright
echo "Running Playwright tests..."
npx playwright test --reporter=allure-playwright
if [ $? -ne 0 ]; then
    echo "Playwright tests failed!"
    exit 1
fi

# Генерируем Allure отчет
echo "Generating Allure report..."
allure generate allure-results --clean -o allure-report
if [ $? -ne 0 ]; then
    echo "Failed to generate Allure report!"
    exit 1
fi

# Отправляем уведомление через Telegram
echo "Sending Telegram notification..."
java -DconfigFile=/app/notifications/telegram.json -jar /app/notifications/allure-notifications-4.8.0.jar
if [ $? -ne 0 ]; then
    echo "Failed to send Telegram notification!"
    exit 1
fi

echo "All steps completed successfully!"
