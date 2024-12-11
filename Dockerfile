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
    libenchant-2-2 \
    libicu-dev \
    fonts-liberation \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Playwright
RUN npx playwright install-deps
RUN npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Команда для запуска тестов
CMD ["sh", "-c", "npx playwright test && npx allure generate allure-results --clean -o allure-report && curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64 && chmod +x allurectl && ./allurectl upload --project-id $ALLURE_PROJECT_ID --results-dir allure-results --server $ALLURE_SERVER_URL --token $ALLURE_TOKEN"]
