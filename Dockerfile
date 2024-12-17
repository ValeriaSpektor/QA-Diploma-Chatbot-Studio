# Используем базовый образ Playwright
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY . .

# Даем права на выполнение Playwright
RUN chmod -R 777 /app

# Устанавливаем зависимости
RUN npm install

# Устанавливаем Playwright браузеры
RUN npx playwright install --with-deps

# Запускаем тесты
CMD ["npx", "playwright", "test"]
