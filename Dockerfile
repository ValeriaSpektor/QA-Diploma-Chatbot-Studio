# Базовый образ
FROM node:16-bullseye

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем зависимости для Playwright
RUN npx playwright install --with-deps

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем Java для Allure-уведомлений
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Настраиваем переменные окружения для Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Настраиваем права для всех исполняемых файлов
RUN chmod +x /app/entrypoint.sh
RUN chmod +x /usr/local/bin/playwright

# Команда для запуска тестов
CMD ["/app/entrypoint.sh"]
