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

# Обновляем систему и устанавливаем недостающие зависимости
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libevent-dev \
    libicu-dev \
    fonts-liberation \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Playwright и Allure CLI
RUN npx playwright install-deps
RUN npx playwright install
RUN npm install -g allure-commandline --save-dev

# Копируем Allurectl для загрузки результатов
RUN curl -o allurectl https://github.com/allure-framework/allurectl/releases/latest/download/allurectl_linux_amd64 && \
    chmod +x allurectl

# Команда для запуска тестов и загрузки результатов
CMD ["sh", "-c", "npx playwright test && npx allure generate allure-results --clean -o allure-report && ./allurectl upload --project-id $ALLURE_PROJECT_ID --results-dir allure-results --server $ALLURE_SERVER_URL --token $ALLURE_TOKEN"]
