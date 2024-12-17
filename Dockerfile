FROM mcr.microsoft.com/playwright:v1.49.0-jammy

WORKDIR /app

# Установка зависимостей проекта
COPY package*.json ./
RUN npm install

# Добавление прав на выполнение Playwright
RUN chmod -R 755 /app/node_modules/.bin

# Копирование кода проекта
COPY . .

# Команда для запуска Playwright тестов
CMD ["npx", "playwright", "test"]
