#!/bin/bash

# Логирование для отладки
echo "Запуск сервера для Allure-отчета..."

# Запускаем http-server для Allure-отчета
http-server /app/allure-report -p 8080 &
SERVER_PID=$!

# Ждем, пока сервер запустится
echo "Ждем 5 секунд для запуска сервера..."
sleep 5

# Логируем запуск тестов
echo "Запуск тестов Playwright..."
npx playwright test || {
  echo "Тесты завершились с ошибкой. Завершаем процесс..."
  kill $SERVER_PID
  exit 1
}

# Остановка сервера
echo "Остановка сервера..."
kill $SERVER_PID

# Если все успешно
echo "Тестирование завершено успешно!"
exit 0
