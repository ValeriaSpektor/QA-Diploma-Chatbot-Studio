# Используем последний Playwright с поддержкой Edge
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем все файлы проекта
COPY . .

# Устанавливаем зависимости
RUN npm install --legacy-peer-deps

# Запуск тестов с передачей браузера
CMD ["npx", "playwright", "test", "--browser", "msedge"]
