#!/bin/bash

# Запуск Playwright тестов
npx playwright test --reporter=allure-playwright

# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report

# Запуск локального HTTP-сервера для Allure отчета
http-server allure-report -p 8080 &

# Публикация отчета в Telegram
curl -F chat_id="$TELEGRAM_CHAT_ID" \
     -F document=@allure-report/index.html \
     -F caption="📝 Allure Report\n
✅ Passed: $(jq '.statistic.passed' allure-results/summary.json)\n
❌ Failed: $(jq '.statistic.failed' allure-results/summary.json)\n
⚠️ Broken: $(jq '.statistic.broken' allure-results/summary.json)\n
➖ Skipped: $(jq '.statistic.skipped' allure-results/summary.json)\n
📊 Total: $(jq '.statistic.total' allure-results/summary.json)\n\n
🔗 View the report: http://localhost:8080" \
     "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendDocument"
