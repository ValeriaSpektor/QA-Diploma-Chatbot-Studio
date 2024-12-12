#!/bin/bash

# Запуск тестов Playwright
npx playwright test

# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report

# Загрузка Allure CLI
curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64
chmod +x allurectl

# Отправка отчета в Allure TestOps
./allurectl upload --project-id $ALLURE_PROJECT_ID \
                   --results-dir allure-results \
                   --server $ALLURE_SERVER_URL \
                   --token $ALLURE_TOKEN

# Отправка уведомления в Telegram
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="Уведомления о статусе CI/CD успешно подключены! Теперь вы будете получать отчеты о тестах и результатах загрузки.\n\nСсылка на отчет Allure: $ALLURE_REPORT_URL"
