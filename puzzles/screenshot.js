const puppeteer = require('puppeteer');
const currentDirectory = process.cwd();

puppeteer.launch().then(async browser => {
  async function screenshotDOMElement(selector, padding = 0) {
    const rect = await page.evaluate((selector) => {
      const element = document.querySelector(selector);
      const { x, y, width, height } = element.getBoundingClientRect();
      return { left: x, top: y, width: width * 1.155, height: height * 1.155, id: element.id };
    }, selector);

    return await page.screenshot({
      path: `${currentDirectory}/shot-big.jpeg`,
      clip: {
        x: rect.left - padding,
        y: rect.top - padding,
        width: rect.width + padding * 2,
        height: rect.height + padding * 2
      }
    });
  };

  const page = await browser.newPage();
  await page.goto(`file://${currentDirectory}/nsg-2019/index.html`);
  await screenshotDOMElement('div#crossword-board');

  browser.close();
});
