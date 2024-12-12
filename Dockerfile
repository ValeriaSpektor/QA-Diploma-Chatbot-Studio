# Указываем платформу и базовый образ
FROM --platform=linux/amd64 node:16-bullseye 

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
   dos2unix \
   --no-install-recommends && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

# Устанавливаем Playwright и его зависимости
RUN npx playwright install-deps
RUN npx playwright install

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Скачиваем и настраиваем allurectl
RUN wget https://repo.maven.apache.org/maven2/io/qameta/allure/allurectl/2.13.10/allurectl-2.13.10-linux-x86_64 -O /usr/local/bin/allurectl && \
   chmod +x /usr/local/bin/allurectl && \
   dos2unix /usr/local/bin/allurectl

# Создаем скрипт для запуска тестов
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Запускаем тесты\n\
npx playwright test\n\
\n\
# Генерируем отчет\n\
npx allure generate allure-results --clean -o allure-report\n\
\n\
# Загружаем результаты\n\
allurectl upload \\\n\
   --project-id "$ALLURE_PROJECT_ID" \\\n\
   --results-dir allure-results \\\n\
   --server "$ALLURE_SERVER_URL" \\\n\
   --token "$ALLURE_TOKEN"' > /app/run-tests.sh

# Делаем скрипт исполняемым и исправляем концы строк
RUN chmod +x /app/run-tests.sh && \
   dos2unix /app/run-tests.sh

# Команда для запуска тестов
CMD ["/app/run-tests.sh"]
