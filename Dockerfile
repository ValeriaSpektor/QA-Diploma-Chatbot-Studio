# Используем базовый образ Node.js
FROM node:16-bullseye

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    wget gnupg libevent-dev libicu-dev \
    openjdk-11-jdk-headless xvfb --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Исправляем права для Playwright
RUN mkdir -p /usr/local/share/.cache && \
    chmod -R 777 /usr/local/share/.cache && \
    chmod -R 777 /app

# Устанавливаем Playwright и Allure
RUN npx playwright install-deps && npx playwright install
RUN npm install -g allure-commandline --save-dev

# Добавляем права для entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Запуск
CMD ["/app/entrypoint.sh"]
