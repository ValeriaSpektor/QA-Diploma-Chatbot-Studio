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

# Устанавливаем Playwright и браузеры
RUN npx playwright install --with-deps

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Добавляем JAR файл для уведомлений
COPY notifications/allure-notifications-4.8.0.jar /app/

# Команда для запуска тестов
CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report"]