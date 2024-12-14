#!/bin/bash

# Запуск тестов Playwright
npx playwright test --reporter=allure-playwright

# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report

# Отправка отчета в Allure TestOps
if [ -n "$ALLURE_PROJECT_ID" ] && [ -n "$ALLURE_SERVER_URL" ] && [ -n "$ALLURE_TOKEN" ]; then
  curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64
  chmod +x allurectl
  ./allurectl upload --project-id "$ALLURE_PROJECT_ID" \
                     --results-dir allure-results \
                     --server "$ALLURE_SERVER_URL" \
                     --token "$ALLURE_TOKEN"
fi

# Отправка уведомления в Telegram
if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ]; then
  curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
       -d chat_id="$TELEGRAM_CHAT_ID" \
       -d text="Тесты выполнены. Отчет Allure доступен."
fi
