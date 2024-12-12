# Используем базовый образ Node.js с поддержкой Playwright
FROM mcr.microsoft.com/playwright:v1.39.0-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Устанавливаем Allure CLI глобально
RUN npm install -g allure-commandline --save-dev

# Копируем проект в контейнер
COPY . .

# Устанавливаем Java для запуска Allure Notifications
RUN apt-get update && apt-get install -y openjdk-11-jdk --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Устанавливаем JAVA_HOME и добавляем его в PATH
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Копируем JAR файл Allure Notifications
COPY notifications/allure-notifications-4.8.0.jar /app/allure-notifications-4.8.0.jar

# Копируем конфигурационный файл для Telegram
COPY notifications/telegram.json /app/telegram.json

# Проверяем наличие файлов и делаем JAR файл исполняемым
RUN chmod +x /app/allure-notifications-4.8.0.jar

# Запуск тестов и генерация отчета
CMD ["sh", "-c", \
    "npx playwright test --reporter=allure-playwright && \
    allure generate allure-results --clean -o allure-report && \
    java -jar /app/allure-notifications-4.8.0.jar"]
