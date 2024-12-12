# Используем базовый образ Node.js
FROM node:16-bullseye

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Устанавливаем Playwright и зависимости для браузеров
RUN npx playwright install-deps
RUN npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем Java для Allure Notifications
RUN apt-get update && apt-get install -y openjdk-11-jdk-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Копируем весь проект
COPY . .

# Копируем конфигурационный файл Telegram
COPY notifications/telegram.json /app/notifications/telegram.json

# Устанавливаем права на выполнение скрипта entrypoint.sh
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Команда для запуска
CMD ["/app/entrypoint.sh"]
