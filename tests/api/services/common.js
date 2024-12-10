import supertest from 'supertest';
import { faker } from '@faker-js/faker';

// Базовый URL API
const BASE_URL = process.env.API_URL || 'https://chatgpt.ai-chatbot.studio/api';
const apiRequest = supertest(BASE_URL);

// Функция для генерации случайных данных (например, для тестов регистрации)
export const generateRandomUser = () => ({
  fullName: faker.person.fullName(),
  email: faker.internet.email(),
  username: faker.internet.username(),
  password: faker.internet.password(8),
});

// Функция для проверки базовых свойств ответа
export const validateApiResponse = (response, expectedStatus) => {
  if (response.status !== expectedStatus) {
    throw new Error(
      `Ожидался статус ${expectedStatus}, но получен ${response.status}: ${response.body?.message || response.text}`
    );
  }
};

// Экспорт API-запроса
export { apiRequest };
