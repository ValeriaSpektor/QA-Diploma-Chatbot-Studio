FROM node:16-bullseye

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN npx playwright install-deps
RUN npx playwright install
RUN npm install -g allure-commandline --save-dev

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Проверка наличия файлов
RUN ls -la /app/notifications

CMD ["sh", "-c", "npx playwright test --reporter=allure-playwright && allure generate allure-results --clean -o allure-report && java -jar /app/notifications/allure-notifications-4.8.0.jar"]
