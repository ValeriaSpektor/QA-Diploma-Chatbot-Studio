import { test, expect } from '@playwright/test';

const API_BASE_URL = 'https://chatgpt.ai-chatbot.studio/api';

test.describe('API Тесты логина', () => {
  test('Ошибка при неверном пароле', async () => {
    const userWithWrongPassword = {
      email: 'new.user@mail.ru',
      password: 'wrongpassword',
    };

    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userWithWrongPassword),
    });

    const responseBody = await response.json();
    console.log('Response status:', response.status);
    console.log('Response body:', responseBody);

    // Проверка, что статус равен 404 и сообщение об ошибке верное
    expect(response.status).toBe(404);
    expect(responseBody).toHaveProperty('message', 'Incorrect password.');
  });

  test('Ошибка при неверном email', async () => {
    const userWithWrongEmail = {
      email: 'wrong.user@mail.ru',
      password: '542073vl',
    };

    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userWithWrongEmail),
    });

    const responseBody = await response.json();
    console.log('Response status:', response.status);
    console.log('Response body:', responseBody);

    // Проверка, что статус равен 404 и сообщение об ошибке верное
    expect(response.status).toBe(404);
    expect(responseBody).toHaveProperty('message', 'Email does not exist.');
  });

  test('Ошибка при пустом теле запроса', async () => {
    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({}),
    });

    const responseBody = await response.json();
    console.log('Response status:', response.status);
    console.log('Response body:', responseBody);

    // Проверка, что статус равен 404 и сообщение об ошибке верное
    expect(response.status).toBe(404);
    expect(responseBody).toHaveProperty('message', 'Missing credentials');
  });

  test('Ошибка при отсутствии email', async () => {
    const userWithoutEmail = {
      password: '542073vl',
    };

    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userWithoutEmail),
    });

    const responseBody = await response.json();
    console.log('Response status:', response.status);
    console.log('Response body:', responseBody);

    // Проверка, что статус равен 404 и сообщение об ошибке верное
    expect(response.status).toBe(404);
    expect(responseBody).toHaveProperty('message', 'Missing credentials');
  });

  test('Ошибка при отсутствии password', async () => {
    const userWithoutPassword = {
      email: 'new.user@mail.ru',
    };

    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userWithoutPassword),
    });

    const responseBody = await response.json();
    console.log('Response status:', response.status);
    console.log('Response body:', responseBody);

    // Проверка, что статус равен 404 и сообщение об ошибке верное
    expect(response.status).toBe(404);
    expect(responseBody).toHaveProperty('message', 'Missing credentials');
  });

  test('Успешный логин существующего пользователя', async () => {
    const existingUser = {
      email: 'new.user@mail.ru',
      password: '542073vl',
    };

    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(existingUser),
    });

    const responseBody = await response.json();
    console.log('Response status:', response.status);
    console.log('Response body:', responseBody);

    // Проверка, что статус равен 200 и токен присутствует
    expect(response.status).toBe(200);
    expect(responseBody).toHaveProperty('token');
    expect(responseBody.user.email).toBe(existingUser.email);
  });
});
