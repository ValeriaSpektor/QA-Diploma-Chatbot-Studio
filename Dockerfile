FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Устанавливаем Playwright
RUN npx playwright install --with-deps

# Устанавливаем права на Playwright
RUN chmod +x /app/node_modules/.bin/playwright

# Копируем весь проект
COPY . .

# Запускаем тесты Playwright
CMD ["npx", "playwright", "test"]
