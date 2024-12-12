# Используем образ Node.js с Bullseye
FROM node:16-bullseye

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Устанавливаем Playwright
RUN npx playwright install --with-deps

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем Java
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Настраиваем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Копируем проект
COPY . .

# Копируем JAR файл для уведомлений
COPY notifications/allure-notifications-4.8.0.jar /app/

# Копируем файл конфигурации для Telegram
COPY notifications/telegram.json /app/telegram.json

# Команда для запуска тестов
CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report && java -DconfigFile=/app/telegram.json -jar /app/allure-notifications-4.8.0.jar"]
