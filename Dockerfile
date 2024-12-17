FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Устанавливаем Allure и другие необходимые зависимости
RUN apt-get update && apt-get install -y openjdk-11-jdk curl unzip

# Устанавливаем права на Playwright
RUN chmod +x /app/node_modules/.bin/playwright

# Копируем проект в контейнер
WORKDIR /app
COPY . /app

# Устанавливаем зависимости проекта
RUN npm install

# Устанавливаем Allure Commandline
RUN curl -o allure-commandline.zip -L https://github.com/allure-framework/allure2/releases/download/2.21.0/allure-2.21.0.zip && \
    unzip allure-commandline.zip && \
    mv allure-2.21.0 /opt/allure && \
    ln -s /opt/allure/bin/allure /usr/bin/allure

# Запускаем Playwright тесты и создаем отчет
CMD ["npx", "playwright", "test"]
