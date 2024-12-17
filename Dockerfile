# Используем базовый образ Node.js с поддержкой Playwright
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package.json package-lock.json ./
RUN npm ci

# Копируем тесты и конфигурацию
COPY . .

# Запускаем Playwright-тесты
CMD ["npx", "playwright", "test", "--reporter=allure-playwright"]
