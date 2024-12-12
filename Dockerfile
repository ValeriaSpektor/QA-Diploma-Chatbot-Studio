FROM node:16-bullseye

WORKDIR /app

# Устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Копируем проект
COPY . .

# Устанавливаем Playwright
RUN npx playwright install --with-deps

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем Java
RUN apt-get update && apt-get install -y openjdk-11-jdk-headless

# Копируем файл конфигурации Telegram
COPY notifications/telegram.json /app/telegram.json

# Убеждаемся, что файл скопирован
RUN ls -la /app

# Настраиваем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report && java -jar /app/allure-notifications-4.8.0.jar -DconfigFile=/app/telegram.json"]
