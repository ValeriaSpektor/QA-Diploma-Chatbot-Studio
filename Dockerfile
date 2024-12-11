# Используем базовый образ Node.js
FROM node:16

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь проект
COPY . .

# Устанавливаем зависимости для Playwright
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libcups2 \
    libxshmfence1 \
    libdbus-glib-1-2 \
    xvfb

# Устанавливаем Playwright
RUN npx playwright install-deps
RUN npx playwright install

# Команда для запуска автотестов с Xvfb
CMD ["xvfb-run", "--server-args=-screen 0 1920x1080x24", "npx", "playwright", "test"]
