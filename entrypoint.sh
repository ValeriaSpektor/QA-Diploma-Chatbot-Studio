#!/bin/bash

echo "Checking if telegram.json exists..."
if [ -f /app/notifications/telegram.json ]; then
    echo "telegram.json found:"
    cat /app/notifications/telegram.json
else
    echo "telegram.json not found, exiting..."
    exit 1
fi

echo "Running Playwright tests..."
npx playwright test --reporter=allure-playwright || { echo "Playwright tests failed!"; exit 1; }

echo "Generating Allure report..."
allure generate allure-results --clean -o allure-report || { echo "Failed to generate Allure report!"; exit 1; }

echo "Sending Telegram notification..."
java -jar /app/allure-notifications-4.8.0.jar || { echo "Failed to send Telegram notification!"; exit 1; }

echo "All steps completed successfully."
