#!/bin/bash

# Чтение данных из summary.json
SUMMARY_FILE="allure-report/widgets/summary.json"

if [ -f "$SUMMARY_FILE" ]; then
  PASSED=$(jq '.statistic.passed' $SUMMARY_FILE)
  FAILED=$(jq '.statistic.failed' $SUMMARY_FILE)
  BROKEN=$(jq '.statistic.broken' $SUMMARY_FILE)
  SKIPPED=$(jq '.statistic.skipped' $SUMMARY_FILE)
  TOTAL=$(jq '.statistic.total' $SUMMARY_FILE)

  # Формирование текста для уведомления
  MESSAGE="📝 Allure Report\n"
  MESSAGE+="✅ Passed: $PASSED\n"
  MESSAGE+="❌ Failed: $FAILED\n"
  MESSAGE+="⚠️ Broken: $BROKEN\n"
  MESSAGE+="➖ Skipped: $SKIPPED\n"
  MESSAGE+="📊 Total: $TOTAL\n\n"
  MESSAGE+="🔗 View the report: https://valeriaspektor.github.io/QA-Diploma-Chatbot-Studio/"
else
  MESSAGE="⚠️ Allure Report summary.json not found. Please check the pipeline logs."
fi

# Отправка уведомления в Telegram
curl -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendPhoto" \
  -F chat_id="${TELEGRAM_CHAT_ID}" \
  -F photo="@allure-report/widgets/summary-chart.json" \
  -F caption="$MESSAGE"
