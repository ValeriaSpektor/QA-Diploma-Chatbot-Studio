const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  // Укажите URL вашего Allure отчета
  await page.goto('http://localhost:8080/index.html');

  // Сделайте скриншот и сохраните его
  await page.screenshot({ path: 'allure-report-screenshot.png', fullPage: true });

  await browser.close();
})();
