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

# Уведомление в Telegram
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="✅ Тесты завершены. Отчёт Allure создан: https://allure.autotests.cloud/project/$ALLURE_PROJECT_ID/dashboards"

# Отправка файла-скриншота отчёта (если доступен)
ALLURE_SCREENSHOT="allure-report/index.html"
if [ -f "$ALLURE_SCREENSHOT" ]; then
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendDocument" \
       -F chat_id=$TELEGRAM_CHAT_ID \
       -F document=@"$ALLURE_SCREENSHOT" \
       -F caption="Allure Report"
else
  echo "❌ Скриншот Allure отчёта не найден!"
fi

exit $TEST_STATUS
