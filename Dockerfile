# Используем базовый образ
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY package.json package-lock.json ./
COPY . .

# Устанавливаем зависимости
RUN npm install

# Добавляем права на выполнение Playwright
RUN chmod +x /app/node_modules/.bin/playwright

# Запускаем Playwright тесты
CMD ["npx", "playwright", "test"]
