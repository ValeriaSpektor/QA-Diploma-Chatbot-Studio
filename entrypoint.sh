#!/bin/bash
set -e

# Запускаем тесты Playwright
echo "Running tests..."
npx playwright test --reporter=line,allure-playwright

# Генерируем Allure отчет
echo "Generating Allure report..."
allure generate allure-results --clean -o allure-report

# Поднимаем HTTP сервер для просмотра Allure отчета
echo "Starting HTTP server for Allure report..."
npx http-server allure-report -p 8080
