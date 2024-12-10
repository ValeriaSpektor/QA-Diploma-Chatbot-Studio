export class LoginPage {
  constructor(page) {
    this.page = page;
    this.emailInput = page.locator('input#email');
    this.passwordInput = page.locator('input#password');
    this.loginButton = page.locator('button[data-testid="login-button"]');
  }

  async open() {
    await this.page.goto('https://chatgpt.ai-chatbot.studio/login');
  }

  async login(email, password) {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.loginButton.click();
  }
}
