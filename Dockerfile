# Используем базовый образ Playwright
FROM mcr.microsoft.com/playwright:v1.39.0-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект
COPY . .

# Добавляем права на выполнение для всех файлов
RUN chmod -R 777 /app

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Устанавливаем переменные окружения для Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Добавляем скрипт entrypoint.sh
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Команда для запуска entrypoint.sh
CMD ["/app/entrypoint.sh"]
