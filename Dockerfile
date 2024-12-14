# Используем базовый образ Node.js с поддержкой Playwright
FROM mcr.microsoft.com/playwright:v1.39.0-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект
COPY . .

# Добавляем права на выполнение скриптов
RUN chmod -R 777 /app

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем переменные окружения для Java (для Allure)
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Запускаем Playwright тесты и создаем Allure отчет
CMD ["sh", "-c", "npx playwright test && npx allure generate allure-results --clean -o allure-report"]
