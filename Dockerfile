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
    openjdk-11-jdk \
    libevent-dev \
    libenchant-2-2 \
    libicu-dev \
    fonts-liberation \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем переменные окружения для Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Устанавливаем Playwright
RUN npx playwright install-deps
RUN npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Загружаем Allurectl и даем права на выполнение
RUN curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64 && \
    chmod +x allurectl

# Команда для запуска тестов
CMD ["sh", "-c", "npx playwright test && npx allure generate allure-results --clean -o allure-report && ./allurectl upload --project-id $ALLURE_PROJECT_ID --results-dir allure-results --server $ALLURE_SERVER_URL --token $ALLURE_TOKEN"]
