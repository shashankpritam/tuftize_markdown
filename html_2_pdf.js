const puppeteer = require('puppeteer');
const path = require('path');

async function htmlToPDF(inputFile, outputFile) {
    const absoluteInputPath = path.resolve(inputFile);
    console.log(`Starting PDF conversion from ${absoluteInputPath} to ${outputFile}`);
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    try {
        await page.goto(`file://${absoluteInputPath}`, { waitUntil: 'networkidle0' });
        await page.pdf({ path: outputFile, format: 'A4' });
        console.log(`PDF successfully created at ${outputFile}`);
    } catch (err) {
        console.error('Failed to create PDF:', err);
    } finally {
        await browser.close();
    }
}

const args = process.argv.slice(2);
if (args.length < 2) {
    console.error("Usage: node script.js <input_file.html> <output_file.pdf>");
    process.exit(1);
}
htmlToPDF(args[0], args[1]).catch(err => console.error('Error in htmlToPDF:', err));
