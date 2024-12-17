# Используем официальный Playwright образ с Node.js
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY . .

# Устанавливаем зависимости
RUN npm ci

# Запускаем тесты Playwright
CMD ["npx", "playwright", "test"]
