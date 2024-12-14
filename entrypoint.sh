#!/bin/bash

echo "Starting Playwright tests..."

# Запуск тестов Playwright
npx playwright test
if [ $? -ne 0 ]; then
  echo "Playwright tests failed!"
  exit 1
fi

echo "Generating Allure report..."
# Генерация Allure отчета
npx allure generate allure-results --clean -o allure-report
if [ $? -ne 0 ]; then
  echo "Failed to generate Allure report!"
  exit 1
fi

echo "Uploading Allure report to Allure TestOps..."
# Загрузка Allure отчета в TestOps
curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64
chmod +x allurectl
./allurectl upload --project-id $ALLURE_PROJECT_ID \
                   --results-dir allure-results \
                   --server $ALLURE_SERVER_URL \
                   --token $ALLURE_TOKEN
if [ $? -ne 0 ]; then
  echo "Failed to upload Allure report!"
  exit 1
fi

echo "Sending Telegram notification..."
# Отправка уведомления в Telegram
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="CI/CD завершен. Отчет доступен по ссылке: $ALLURE_REPORT_URL"
if [ $? -ne 0 ]; then
  echo "Failed to send Telegram notification!"
  exit 1
fi

echo "Pipeline completed successfully!"
