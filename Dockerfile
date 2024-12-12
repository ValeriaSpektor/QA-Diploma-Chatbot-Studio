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
    openjdk-11-jdk-headless \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Playwright
RUN npx playwright install-deps
RUN npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Команда для запуска тестов и отправки уведомления в Telegram
CMD ["sh", "-c", "npx playwright test && \
    npx allure generate allure-results --clean -o allure-report && \
    curl -o allurectl https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64 && \
    chmod +x allurectl && \
    ./allurectl upload --project-id $ALLURE_PROJECT_ID --results-dir allure-results --server $ALLURE_SERVER_URL --token $ALLURE_TOKEN && \
    curl -X POST \"https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage\" \
    -d chat_id=$TELEGRAM_CHAT_ID \
    -d text=\"Уведомления о статусе CI/CD успешно подключены! Теперь вы будете получать отчеты о тестах и результатах загрузки.\n\nСсылка на отчет Allure: $ALLURE_REPORT_URL\""]

