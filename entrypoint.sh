#!/bin/bash

# Остановка скрипта при любой ошибке
set -e

echo ">>> Установка зависимостей Playwright"
npx playwright install

echo ">>> Запуск тестов Playwright"
npx playwright test || {
  echo ">>> Ошибка при выполнении тестов Playwright"
  exit 1
}

echo ">>> Генерация Allure-отчета"
npx allure generate --clean ./allure-results || {
  echo ">>> Ошибка при генерации Allure-отчета"
  exit 1
}

echo ">>> Запуск локального сервера для Allure-отчета"
http-server ./allure-report -p 8080 &

echo ">>> Отчет доступен по адресу: http://localhost:8080"

# Поддерживаем контейнер активным, чтобы сервер продолжал работать
tail -f /dev/null
