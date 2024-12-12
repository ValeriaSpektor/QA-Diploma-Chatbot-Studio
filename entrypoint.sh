#!/bin/bash

# Убедитесь, что файл конфигурации существует
if [ ! -f /app/telegram.json ]; then
  echo "Config file /app/telegram.json not found!"
  exit 1
fi

# Запускаем Allure Notifications
java -jar /app/allure-notifications-4.8.0.jar -DconfigFile=/app/telegram.json
