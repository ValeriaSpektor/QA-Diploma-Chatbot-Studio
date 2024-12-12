FROM node:16-bullseye

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npx playwright install --with-deps
RUN npm install -g allure-commandline --save-dev

# Скачиваем JAR-файл для уведомлений
RUN wget -O /app/allure-notifications-4.8.0.jar https://repo.maven.apache.org/maven2/io/qameta/allure/allure-notifications/4.8.0/allure-notifications-4.8.0.jar

CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report"]
