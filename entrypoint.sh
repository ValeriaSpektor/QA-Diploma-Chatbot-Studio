#!/bin/bash

# Запуск тестов
npx playwright test
TEST_STATUS=$?  # Сохраняем статус выполнения (0 — успешно, не 0 — есть ошибки)

# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report

# Интеграция с Allure плагином
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="Allure Report доступен: https://allure.autotests.cloud/project/$ALLURE_PROJECT_ID/dashboards"

# Уведомление в Telegram
if [ $TEST_STATUS -eq 0 ]; then
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
       -d chat_id=$TELEGRAM_CHAT_ID \
       -d text="✅ Тесты успешно завершены. Allure Report: https://allure.autotests.cloud/project/$ALLURE_PROJECT_ID/dashboards"
else
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
       -d chat_id=$TELEGRAM_CHAT_ID \
       -d text="❌ Некоторые тесты упали. Проверьте отчет: https://allure.autotests.cloud/project/$ALLURE_PROJECT_ID/dashboards"
fi

# Конец скрипта
exit $TEST_STATUS
