FROM mcr.microsoft.com/playwright:v1.39.0-jammy

# Установка Java для Allure Notifications
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Установка Allure CLI
RUN curl -o allure-2.21.0.tgz -L https://github.com/allure-framework/allure2/releases/download/2.21.0/allure-2.21.0.tgz && \
    tar -zxvf allure-2.21.0.tgz && \
    mv allure-2.21.0 /opt/allure && \
    ln -s /opt/allure/bin/allure /usr/bin/allure

# Установка зависимостей
WORKDIR /app
COPY package*.json ./
RUN npm install

# Копирование тестов и конфигурации
COPY . .

# Запуск тестов и генерация Allure Report
CMD ["sh", "-c", "npx playwright test && allure generate allure-results -o allure-report --clean"]
