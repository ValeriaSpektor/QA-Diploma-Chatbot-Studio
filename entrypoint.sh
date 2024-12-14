#!/bin/bash

# Запуск Playwright тестов
echo "Running Playwright tests..."
npx playwright test || exit 1

# Генерация Allure отчета
echo "Generating Allure report..."
npx allure generate allure-results --clean -o allure-report || exit 1

# Отправка Allure отчета в TestOps
echo "Uploading Allure report to TestOps..."
curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64
chmod +x allurectl
./allurectl upload --project-id $ALLURE_PROJECT_ID \
                   --results-dir allure-results \
                   --server $ALLURE_SERVER_URL \
                   --token $ALLURE_TOKEN || exit 1

# Отправка уведомления в Telegram
echo "Sending Telegram notification..."
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="Docker tests completed successfully!" || exit 1

echo "All tasks completed successfully."
