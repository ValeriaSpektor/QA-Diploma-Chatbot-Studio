#!/bin/bash

# Запускаем тесты с Playwright и сохраняем результаты в Allure
npx playwright test --reporter=allure-playwright

# Генерируем отчет Allure
allure generate allure-results --clean -o allure-report

# Запускаем HTTP-сервер для отображения отчета Allure
http-server allure-report -p 8080
