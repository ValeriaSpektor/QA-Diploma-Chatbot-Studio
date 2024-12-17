# Используем официальный Node.js образ с Playwright
FROM mcr.microsoft.com/playwright:v1.49.0-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Устанавливаем Playwright с зависимостями
RUN npx playwright install --with-deps

# Устанавливаем права на бинарные файлы Playwright
RUN chmod -R 755 /app/node_modules/.bin

# Копируем все файлы проекта
COPY . .

# Запускаем тесты Playwright
CMD ["npx", "playwright", "test"]
