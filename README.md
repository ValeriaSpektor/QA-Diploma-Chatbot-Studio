# QA Diploma Project - Chatbot Studio

This repository contains the **QA Automation Diploma Project**, showcasing skills in test automation for UI and API testing. The project includes functional tests, reporting, and integration with CI/CD pipelines.

---

## **Project Structure**

- **`tests/ui/`**: Contains UI tests using the Playwright framework and the Page Object Model (POM).
- **`tests/api/`**: Contains API tests structured with services and data generators.
- **`allure-results/`**: Stores raw test results for Allure reporting.
- **`allure-report/`**: Contains the generated Allure HTML report.

---

## **Implemented Features**

### **1. UI Automation**
- **5 Functional Tests**:
  - Login and Registration functionalities.
  - Assertions directly targeting page elements.
- **Page Object Model (POM)**:
  - `LoginPage` and `RegisterPage` classes to encapsulate UI interactions.

### **2. API Automation**
- **5 Functional Tests**:
  - Tests for authentication and CRUD operations.
- **Service Architecture**:
  - Tests use service classes for cleaner logic and data handling.

### **3. CI/CD Integration**
- **GitHub Actions**:
  - CI/CD pipeline set up to run tests on every push and pull request.
  - Sends notifications to Telegram with test results.
- **Notifications**:
  - Automated Telegram messages with test status and results.

### **4. Reporting**
- **Allure Reports**:
  - Integrated with Allure for detailed reporting.
  - Historical data stored in the GitHub repository.
  - Reports accessible locally and via TestOps.

### **5. Mobile Testing (Optional)**
- Tests prepared for Android and iOS platforms (can be extended).

---

## **Technologies Used**

- **Frameworks**: Playwright
- **Languages**: JavaScript
- **CI/CD**: GitHub Actions
- **Reporting**: Allure
- **Communication**: Telegram Notifications

---

## **Setup Instructions**

### **1. Clone the Repository**
```bash
git clone https://github.com/ValeriaSpektor/QA-Diploma-Chatbot-Studio.git
cd QA-Diploma-Chatbot-Studio

