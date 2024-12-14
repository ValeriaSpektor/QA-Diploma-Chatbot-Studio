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
    openjdk-11-jdk-headless \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Playwright
RUN npx playwright install-deps && npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Копируем скрипт entrypoint.sh
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Используем entrypoint.sh для запуска
CMD ["/app/entrypoint.sh"]
