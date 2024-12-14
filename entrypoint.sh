#!/bin/bash

# 1. Запуск автотестов Playwright с генерацией отчета для Allure
echo "Running Playwright Tests..."
npx playwright test --reporter=allure-playwright

# 2. Генерация Allure отчета
echo "Generating Allure Report..."
npx allure generate allure-results --clean -o allure-report

# 3. Загрузка результатов в Allure TestOps
echo "Uploading Results to Allure TestOps..."
curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64
chmod +x allurectl
./allurectl upload --project-id $ALLURE_PROJECT_ID \
                   --results-dir allure-results \
                   --server $ALLURE_SERVER_URL \
                   --token $ALLURE_TOKEN

# 4. Уведомление в Telegram
echo "Sending Telegram Notification..."
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="Allure Report is available at: https://${GITHUB_REPOSITORY_OWNER}.github.io/${GITHUB_REPOSITORY}/"
