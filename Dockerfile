FROM node:16-bullseye

WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем Playwright
RUN npx playwright install --with-deps

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Копируем JAR файл для уведомлений из локального репозитория
COPY notifications/allure-notifications-4.8.0.jar /app/

# Команда для запуска тестов и генерации отчета
CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report && java -jar /app/allure-notifications-4.8.0.jar"]
