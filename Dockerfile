FROM mcr.microsoft.com/playwright:v1.37.0-focal

WORKDIR /app

# Установка зависимостей
COPY package*.json ./
RUN npm install

# Копирование проекта
COPY . .

# Установка Allure
RUN npm install -g allure-commandline --save-dev

# Установка Playwright Browsers
RUN npx playwright install

ENTRYPOINT ["sh", "/app/entrypoint.sh"]
