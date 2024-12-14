# Используем базовый образ Playwright
FROM mcr.microsoft.com/playwright:v1.38.0-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем Allure CLI
RUN npm install -g allure-commandline --save-dev

# Добавляем права на выполнение entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Точка входа
CMD ["/app/entrypoint.sh"]
