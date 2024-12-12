FROM node:16-bullseye

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npx playwright install --with-deps
RUN npm install -g allure-commandline --save-dev

COPY notifications/allure-notifications-4.8.0.jar /app/

CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report"]
