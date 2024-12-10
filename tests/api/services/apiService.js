import supertest from 'supertest';
import { faker } from '@faker-js/faker';

// Базовый URL API
const apiRequest = supertest(process.env.API_URL || 'https://chatgpt.ai-chatbot.studio/api');

/**
 * Генерация случайного пользователя для тестов регистрации
 * @returns {Object} Объект с данными пользователя
 */
export const generateRandomUser = () => {
  return {
    fullName: faker.person.fullName(),
    email: faker.internet.email(),
    password: faker.internet.password(8), // Пароль длиной не менее 8 символов
  };
};

/**
 * Проверка базовых свойств ответа API
 * @param {Object} response - Ответ от API
 * @param {number} expectedStatus - Ожидаемый статус ответа
 */
export const validateApiResponse = (response, expectedStatus) => {
  if (response.status !== expectedStatus) {
    throw new Error(
      `Ожидался статус ${expectedStatus}, но получен ${response.status}: ${response.body?.message || 'Без сообщения'}`
    );
  }
};

/**
 * Авторизация пользователя и получение токена
 * @param {string} email - Email пользователя
 * @param {string} password - Пароль пользователя
 * @returns {Promise<string>} Токен авторизации
 */
export const getAuthToken = async (email, password) => {
  const response = await apiRequest
    .post('/auth/login')
    .send({ email, password })
    .set('Content-Type', 'application/json');

  if (response.status !== 200) {
    throw new Error(`Не удалось авторизоваться: ${response.body?.message || 'Неизвестная ошибка'}`);
  }

  return response.body.token; // Возвращаем токен из ответа
};

/**
 * Отправка POST-запроса
 * @param {string} endpoint - Конечная точка API
 * @param {Object} data - Тело запроса
 * @param {string} token - Токен авторизации (опционально)
 * @returns {Promise<Object>} Ответ от API
 */
export const sendPostRequest = async (endpoint, data, token = null) => {
  const requestBuilder = apiRequest.post(endpoint).send(data).set('Content-Type', 'application/json');
  if (token) {
    requestBuilder.set('Authorization', `Bearer ${token}`);
  }
  return requestBuilder;
};

/**
 * Отправка GET-запроса
 * @param {string} endpoint - Конечная точка API
 * @param {string} token - Токен авторизации (опционально)
 * @returns {Promise<Object>} Ответ от API
 */
export const sendGetRequest = async (endpoint, token = null) => {
  const requestBuilder = apiRequest.get(endpoint).set('Content-Type', 'application/json');
  if (token) {
    requestBuilder.set('Authorization', `Bearer ${token}`);
  }
  return requestBuilder;
};

// Экспортируем базовый запрос API и вспомогательные функции
export { apiRequest };
