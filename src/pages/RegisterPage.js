class RegisterPage {
    constructor(page) {
      this.page = page;
      this.fullNameField = page.locator('input[name="name"]');
      this.usernameField = page.locator('input[name="username"]');
      this.emailField = page.locator('input[name="email"]');
      this.passwordField = page.locator('input[name="password"]');
      this.confirmPasswordField = page.locator('input[name="confirm_password"]');
      this.submitButton = page.locator('button[type="submit"]');
    }
  
    async open() {
      await this.page.goto('https://chatgpt.ai-chatbot.studio/register');
    }
  
    async submitForm(fullName, email, password, confirmPassword, username = '') {
        if (fullName) await this.fullNameField.fill(fullName);
        if (username) await this.usernameField.fill(username);
        if (email) await this.emailField.fill(email);
        if (password) await this.passwordField.fill(password);
        if (confirmPassword) await this.confirmPasswordField.fill(confirmPassword);
      
        // Проверка: если кнопка отключена, не пытаться кликать
        if (await this.submitButton.isEnabled()) {
          await this.submitButton.click();
        }
      }
      
  
    async clearForm() {
        await this.fullNameField.fill('');
        await this.emailField.fill('');
        await this.passwordField.fill('');
        await this.confirmPasswordField.fill('');
        await this.page.waitForTimeout(500); // Небольшая пауза для обновления состояния формы
      }     
  }
  
  export default RegisterPage;
  