### 🎓 QA Diploma Project - Chatbot Studio

---

### 💼 Description
This project is part of a *QA Automation Diploma, showcasing skills in automated testing using **Playwright, **Allure, and **GitHub Actions*. It includes functional tests, detailed reporting, and CI/CD pipeline integration.

---

### 📑 Table of Contents
- [Description](#💼-description)
- [Technologies and Tools](#⚙%ef%b8%8f-technologies-and-tools)
- [Test Cases](#✅-test-cases)
- [Environment Setup](#🛠-environment-setup)
- [Test Execution and Report Generation](#📊-test-execution-and-report-generation)
- [Allure Report Integration](#📊-allure-report-integration)
- [CI/CD and Telegram Notifications](#🚀-cicd-and-telegram-notifications)
- [Test Results](#🎯-test-results)
- [Screenshots](#🖼-screenshots)
- [Conclusion](#🛠%ef%b8%8f-conclusion)

---

### ⚙️ Technologies and Tools
| *Technology*       | *Description*                          |
|----------------------|------------------------------------------|
| *JavaScript*       | Programming language for test scripts   |
| *Playwright*       | Framework for UI automation testing     |
| *Allure*           | Test reporting and visualization        |
| *GitHub Actions*   | CI/CD for automating test execution     |
| *Docker*           | Containerized test execution            |
| *Telegram Bot*     | Notifications with test results sent to chat |

---

### ✅ Test Cases
#### *UI Tests*
- Testing login and registration functionalities.
- Verifying notifications display.
- Validating form fields and error handling.

#### *API Tests*
- Authentication and CRUD operations.
- Validation of error status codes and response structures.

---

### 🛠 Environment Setup
Install dependencies:
bash
npm install
npx playwright install --with-deps

Run tests locally:
bash
npm run test

Generate Allure report:
bash
npm run allure

Run tests in Docker:
bash
docker-compose up --build


---

### 📊 Allure Report Integration
The Allure report provides:
- Test execution timelines and results.
- Diagrams showing passed, failed, and broken tests.
- Detailed logs and historical trends.

#### *Sample Report View:*
![image](https://github.com/user-attachments/assets/e6adaeb4-15ba-4da3-a1ee-e260e2c9062d)


---

### 🚀 CI/CD and Telegram Notifications
- Tests are executed automatically with *GitHub Actions* on every push.
- Tests are also executed in *Docker* for isolated environments.
- Notifications with summarized test results are sent to a *Telegram bot*.

#### *Sample Notification:*
![WhatsApp Image 2024-12-17 at 22 12 51](https://github.com/user-attachments/assets/e929531a-29fd-4625-a3c7-5aaa8ad5b274)


---

### 🎯 Test Results
| *Execution*  | *Scenarios* | *Passed* | *Duration* |
|----------------|---------------|------------|--------------|
| *API Tests*  | 6             | 6          | 12s          |
| *UI Tests*   | 5             | 5          | 18s          |
| *Total*      | 14            | 14 (100%)  | 30s          |

---

### 🖼 Screenshots
#### *Allure Report Overview*
![Allure Report](https://allure.autotests.cloud/launch/43098/?treeId=0)

#### *Telegram Notification*
![WhatsApp Image 2024-12-17 at 22 12 51](https://github.com/user-attachments/assets/3bff7542-e6c0-4dfc-a660-75f908aab091)


---

### 🛠️ Conclusion
This project demonstrates a fully automated test suite with:
- Robust *UI and API test coverage*.
- Integrated *reporting* and *CI/CD workflows*.
- *Dockerized* execution for reliability.
- Notifications delivered to Telegram for quick feedback.

### ⬇️ *Check out the Allure Report here:*
[Allure Report](http://10.0.0.10:52863/index.html#)
