#!/bin/bash

# Запуск API тестов
echo "Запуск API тестов"
npx playwright test tests/api || { echo "API тесты завершились с ошибкой"; exit 1; }

# Запуск UI тестов
echo "Запуск UI тестов"
npx playwright test tests/ui || { echo "UI тесты завершились с ошибкой"; exit 1; }

# Генерация Allure отчета
echo "Генерация Allure отчета"
npx allure generate allure-results --clean || { echo "Ошибка генерации Allure отчета"; exit 1; }

# Передача отчета в Allure TestOps (если используется)
echo "Отправка отчета в Allure TestOps"
curl -X POST -H "Authorization: Bearer $ALLURE_TOKEN" \
  -F "allure-results=@allure-results.zip" \
  https://allure.your-instance.com/api/send-results || { echo "Ошибка отправки отчета в Allure TestOps"; exit 1; }

# Уведомление в Telegram (при необходимости)
echo "Отправка уведомления в Telegram"
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
  -d "chat_id=$TELEGRAM_CHAT_ID" \
  -d "text=Тесты успешно завершены."
