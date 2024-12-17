# Используем официальный образ Playwright с поддержкой браузеров
FROM mcr.microsoft.com/playwright:v1.39.0-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package.json package-lock.json ./
RUN npm install

# Копируем все тесты и код
COPY . .

# Запускаем Playwright тесты
CMD ["npx", "playwright", "test"]
