FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Рабочая директория в контейнере
WORKDIR /app

# Копируем все файлы проекта
COPY . .

# Устанавливаем зависимости
RUN npm ci

# Убедитесь, что playwright установил нужный браузер
RUN npx playwright install --with-deps chromium

# Запуск тестов
CMD ["npx", "playwright", "test"]
