# Используем официальный базовый образ Playwright с необходимыми зависимостями
FROM mcr.microsoft.com/playwright:v1.37.0-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm ci

# Устанавливаем Allure для создания отчетов
RUN npm install -g allure-commandline --save-dev

# Копируем все файлы проекта в контейнер
COPY . .

# Устанавливаем браузеры Playwright
RUN npx playwright install

# Устанавливаем переменные окружения для удобства конфигурации
ENV NODE_ENV=production

# Указываем команду, которая будет выполняться при запуске контейнера
ENTRYPOINT ["sh", "/app/entrypoint.sh"]
