# Используем базовый образ Node.js
FROM node:16-bullseye

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем пользователя root
USER root

# Устанавливаем Playwright и зависимости
RUN npx playwright install --with-deps

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Возвращаемся к обычному пользователю node (опционально)
USER node

# Команда для запуска тестов
CMD ["npx", "playwright", "test"]

