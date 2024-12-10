import { faker } from '@faker-js/faker';

export function generateUserData() {
  return {
    name: faker.name.fullName(),
    email: faker.internet.email(),
    password: faker.internet.password(12),
  };
}
