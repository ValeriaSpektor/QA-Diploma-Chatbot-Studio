#!/bin/bash

# Запуск Playwright тестов
npx playwright test --reporter=allure-playwright

# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report

# Проверка существования summary.json
SUMMARY_FILE="allure-report/widgets/summary.json"
if [ -f "$SUMMARY_FILE" ]; then
  PASSED=$(jq '.statistic.passed' $SUMMARY_FILE)
  FAILED=$(jq '.statistic.failed' $SUMMARY_FILE)
  BROKEN=$(jq '.statistic.broken' $SUMMARY_FILE)
  SKIPPED=$(jq '.statistic.skipped' $SUMMARY_FILE)
  TOTAL=$(jq '.statistic.total' $SUMMARY_FILE)

  # Формируем сообщение для Telegram
  MESSAGE="📝 Allure Report\n"
  MESSAGE+="✅ Passed: $PASSED\n"
  MESSAGE+="❌ Failed: $FAILED\n"
  MESSAGE+="⚠️ Broken: $BROKEN\n"
  MESSAGE+="➖ Skipped: $SKIPPED\n"
  MESSAGE+="📊 Total: $TOTAL\n\n"
  MESSAGE+="🔗 View the report: https://<your-site>/allure-report/index.html"

  # Отправляем сообщение в Telegram
  curl -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
      -d chat_id="${TELEGRAM_CHAT_ID}" \
      -d text="$MESSAGE"
else
  echo "⚠️ summary.json not found!"
fi
