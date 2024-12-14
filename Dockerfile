# Используем базовый образ Node.js
FROM node:16-bullseye

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Обновляем систему и устанавливаем зависимости для Playwright и Java
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libevent-dev \
    libenchant-2-2 \
    libicu-dev \
    fonts-liberation \
    openjdk-11-jdk-headless \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Playwright
RUN npx playwright install-deps
RUN npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Настраиваем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Копируем весь проект в контейнер
COPY . .

# Копируем файл telegram.json
COPY notifications/telegram.json /app/notifications/telegram.json

# Копируем JAR-файл для уведомлений
COPY notifications/allure-notifications-4.8.0.jar /app/allure-notifications-4.8.0.jar

# Копируем скрипт entrypoint.sh
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Команда по умолчанию для запуска
CMD ["/app/entrypoint.sh"]
