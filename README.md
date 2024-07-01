# Tuftize Markdown

🐊 I bullied CjatGPT 4.0 into write this readme due to time constraints. If you need any help you have got mny profile page link where uyou will find my contact info. GG!


Welcome to `tuftize_markdown`, where your Markdown meets the elegance of Edward Tufte's design principles, without losing any of its geeky charm. Who said academic documents had to be dull?

## What's Inside?

```
.
├── Justfile
├── LICENSE
├── README.md
├── html_2_pdf.js
├── tufte-handout.lua
├── tufte.css
└── tufte.html5
```

From the nerdy depths of `tufte.css` to the magical automation of `html_2_pdf.js`, every file here serves a purpose. Whether that purpose is profound or just pretentious, only time will tell.

## How to Use This Wizardry

### Setup

First, clone this repository or download the ZIP and extract it like you're opening a treasure chest:

```bash
git clone https://github.com/yourgithub/tuftize_markdown.git
cd tuftize_markdown
```

### Running the Show

Our Justfile commands make the magic happen. Here's how to invoke:

## Installing Just

Before you can run any of the provided commands in the Justfile, you'll need to have `just` installed on your system. `just` is a handy command runner that simplifies complex command sequences.

### Install Just on Various Operating Systems

- **On macOS**:
  You can install `just` using Homebrew:
  ```bash
  brew install just
  ```

- **On Linux**:
  - For Debian-based distributions (like Ubuntu), use this command:
    ```bash
    sudo apt-get install just
    ```
  - For Arch Linux, use pacman:
    ```bash
    sudo pacman -S just
    ```

- **On Windows**:
  You can install `just` using Scoop:
  ```bash
  scoop install just
  ```

Alternatively, if you prefer to manually download the binary or if you are using a different package manager, you can find the latest releases on the [Just GitHub Releases page](https://github.com/casey/just/releases).

### Verify Installation

To verify that `just` is installed correctly, run the following command in your terminal:

```bash
just --version
```

This command should output the version of `just` that you have installed, confirming that it is ready to use.

---

## Usage Instructions

With `just` installed, you are now ready to execute commands defined in the Justfile to manage project tasks such as building HTML, converting to PDF, and cleaning up generated files.

### Building HTML from Markdown

```bash
just build your_markdown_file.md
```

### Converting HTML to PDF

```bash
just html-to-pdf your_html_file.html
```

### Full Workflow

To process a Markdown file directly to PDF in one go:

```bash
just build-and-pdf your_markdown_file.md
```

### Clean Up Generated Files

To clean all generated HTML and PDF files:

```bash
just clean-all
```

### Cleaning Up

After you're done conjuring up documents, you might want to clean up the mystical residue:

```bash
just clean-all
```

This incantation removes all generated HTML and PDF files, because a tidy lair is a happy lair.

## Continuous Enchantment

If you fear the drudgery of manual labor:

```bash
just watch
```

This spell keeps an eye on your Markdown files and rebuilds them as soon as they change. It's like having an apprentice for free!

Adding a dependencies section to your README can help users understand what they need to install before they can fully utilize your project, `tuftize_markdown`. Here’s how you can detail the dependencies and their installation process, focusing on the Node.js environment and the Lua filters used for Pandoc transformations.

### Updated README Section: Dependencies and Setup

---

## Dependencies

### Node.js and Puppeteer

Our project uses Puppeteer for converting HTML files to PDF. You'll need to have Node.js and npm installed to manage our JavaScript dependencies.

1. **Install Node.js**:
   - Visit [Node.js's website](https://nodejs.org/) and download the installer for your operating system.
   - Follow the installation instructions to set up Node.js and npm.

2. **Install Puppeteer**:
   - Puppeteer requires Node.js. Once Node.js is installed, you can install Puppeteer using npm:
     ```bash
     npm install puppeteer
     ```
   - This command will install Puppeteer and its dependencies, which include a version of Chromium that Puppeteer controls.

### Lua Filters for Pandoc

Our project also uses custom Lua filters to enhance the Markdown to HTML conversion process. These filters require Pandoc:

1. **Install Pandoc**:
   - Go to the [Pandoc installation page](https://pandoc.org/installing.html) and follow the instructions for your operating system.

2. **Using Lua Filters**:
   - No additional installation for Lua is required since Pandoc natively supports Lua filters.
   - Ensure the Lua filters (`tufte-handout.lua`, etc.) are correctly placed in your working directory as specified in the Justfile settings.

### Setup and Configuration

Before running any scripts or conversion processes, ensure all environments and dependencies are properly set up:

```bash
just setup
```

This command will check for necessary files and install any missing packages. It prepares your environment to use all the features provided by `tuftize_markdown`.

---

## Usage Instructions

### Building HTML from Markdown

To convert your Markdown documents into HTML styled with Tufte CSS:

```bash
just build your_markdown_file.md
```

### Converting HTML to PDF

For converting the generated HTML files into PDFs:

```bash
just html-to-pdf your_html_file.html
```

This script uses Puppeteer to render the HTML file into a high-quality PDF.

### Full Workflow

To process a Markdown file into an HTML and then a PDF:

```bash
just build-and-pdf your_markdown_file.md
```

### Cleaning Up

To remove all generated files:

```bash
just clean-all
```

This will clean up all HTML and PDF files generated by the build processes to keep your workspace tidy.

---

### Continuous Integration

Set up automated builds and conversions by monitoring file changes:

```bash
just watch
```

This command will watch for any changes in your Markdown files and automatically rebuild them.

---

## License

`tuftize_markdown` is made available under the MIT License. Feel free to use and modify the software in accordance with this license.
