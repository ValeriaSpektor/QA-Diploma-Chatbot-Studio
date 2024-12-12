#!/bin/bash

# Запуск тестов и сохранение результата
npx playwright test
TEST_STATUS=$?  # Сохраняем статус выполнения (0 — успешно, не 0 — есть ошибки)

# Генерация отчета Allure
npx allure generate allure-results --clean -o allure-report

# Путь к Allure отчету (замените на файл, если нужен график)
REPORT_OVERVIEW="allure-report/widgets/summary.json"

# Если тесты прошли успешно
if [ $TEST_STATUS -eq 0 ]; then
  # Отправляем сообщение в Telegram
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
       -d chat_id=$TELEGRAM_CHAT_ID \
       -d text="✅ Тесты прошли успешно! Отчет Allure: https://ваш-сервер-с-отчетами"

  # Если нужен скриншот/данные, отправляем изображение
  if [ -f "$REPORT_OVERVIEW" ]; then
    curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendPhoto" \
         -F chat_id=$TELEGRAM_CHAT_ID \
         -F photo=@"$REPORT_OVERVIEW" \
         -F caption="✅ Тесты прошли успешно! Подробности в Allure."
  fi

else
  # Если тесты упали, отправляем сообщение с текстом ошибки
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
       -d chat_id=$TELEGRAM_CHAT_ID \
       -d text="❌ Тесты завершились с ошибками. Проверьте отчет Allure: https://ваш-сервер-с-отчетами"

  # Также отправляем изображение, если доступно
  if [ -f "$REPORT_OVERVIEW" ]; then
    curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendPhoto" \
         -F chat_id=$TELEGRAM_CHAT_ID \
         -F photo=@"$REPORT_OVERVIEW" \
         -F caption="❌ Тесты завершились с ошибками. Проверьте детали в Allure."
  fi
fi

# Конец скрипта
exit $TEST_STATUS
