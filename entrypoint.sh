#!/bin/bash

# Запуск тестов
npx playwright test
TEST_STATUS=$?

# Проверяем, есть ли результаты Allure
if [ ! -d "allure-results" ] || [ -z "$(ls -A allure-results)" ]; then
  echo "❌ Ошибка: Allure результаты не созданы!"
  exit 1
fi

# Генерация Allure отчёта
npx allure generate allure-results --clean -o allure-report
if [ ! -d "allure-report" ]; then
  echo "❌ Ошибка: Allure отчёт не создан!"
  exit 1
fi

# Создание скриншота отчета
ALLURE_REPORT_FILE="allure-report.png"
npx playwright show-report --port=51705 &
PLAYWRIGHT_PID=$!
sleep 5 # Ждем запуска локального сервера
curl http://localhost:51705/ --output $ALLURE_REPORT_FILE
kill $PLAYWRIGHT_PID

# Уведомление в Telegram
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="✅ Тесты завершены. Отчёт Allure создан."

# Отправка скриншота в Telegram
if [ -f "$ALLURE_REPORT_FILE" ]; then
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendPhoto" \
       -F chat_id=$TELEGRAM_CHAT_ID \
       -F photo=@"$ALLURE_REPORT_FILE" \
       -F caption="Allure Report Screenshot"
else
  echo "❌ Скриншот Allure отчёта не создан!"
fi

exit $TEST_STATUS
