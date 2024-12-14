# Используем базовый образ Node.js с поддержкой Playwright
FROM mcr.microsoft.com/playwright:v1.37.1-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект в контейнер
COPY . .

# Устанавливаем права на выполнение Playwright и всех необходимых скриптов
RUN chmod -R 777 /usr/local/share/.cache && \
    chmod -R 777 /app && \
    chmod +x ./node_modules/.bin/playwright

# Обновляем систему и устанавливаем недостающие зависимости
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libenchant-2-2 \
    libicu-dev \
    fonts-liberation \
    openjdk-11-jdk-headless \
    xvfb \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Allure CLI для генерации отчетов
RUN npm install -g allure-commandline --save-dev

# Устанавливаем локальный http-server для запуска Allure Report
RUN npm install -g http-server

# Устанавливаем JAVA_HOME для работы Allure
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Добавляем права на выполнение entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Используем entrypoint.sh для запуска
CMD ["/app/entrypoint.sh"]
