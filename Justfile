# Use Full Path of File.md
# Use Setup first before running anything
# Justfile for Tufte-style HTML and PDF generation

# Define directories using environment variables with defaults
tufte_css_dir := env_var_or_default("TUFTE_CSS_DIR", "/./tufte-css")
working_dir := env_var_or_default("WORKING_DIR", ".")

# Define CSS files
css_files := "tufte.css"

# Pandoc options
pandoc_options := "--standalone --to html5 --from markdown+smart+pipe_tables --section-divs --mathjax"

# Setup environment
setup:
    #!/usr/bin/env bash
    echo "Setting up environment..."
    # Download tufte.css if not present
    if [ ! -f "{{working_dir}}/tufte.css" ]; then
        curl -o "{{working_dir}}/tufte.css" https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/tufte.css
        echo "Downloaded tufte.css"
    else
        echo "tufte.css already exists."
    fi
    # Download tufte.html5 template if not present
    if [ ! -f "{{working_dir}}/tufte.html5" ]; then
        curl -o "{{working_dir}}/tufte.html5" https://raw.githubusercontent.com/jez/tufte-pandoc-css/master/tufte.html5
        echo "Downloaded tufte.html5 template"
    else
        echo "tufte.html5 template already exists."
    fi
    echo "Setup complete."

# Build HTML from Markdown
build FILE:
    #!/usr/bin/env bash
    echo "Building HTML from {{FILE}}..."
    if [ -f "{{FILE}}" ]; then
        output_file="{{working_dir}}/$(basename "{{FILE}}" .md).html"
        pandoc {{pandoc_options}} \
        --template="{{working_dir}}/tufte.html5" \
        --css tufte.css \
        --filter pandoc-sidenote \
        --lua-filter={{working_dir}}/tufte-handout.lua \
        "{{FILE}}" -o "$output_file"
        echo "{{FILE}} converted to HTML. Output: $output_file"
        ls -l "$output_file"
    else
        echo "Error: {{FILE}} not found."
        exit 1
    fi

# Convert HTML to PDF using Puppeteer
html-to-pdf FILE:
    #!/usr/bin/env bash
    echo "Converting HTML to PDF using Puppeteer: {{FILE}}"
    base_name="$(basename "{{FILE}}" .html)"
    input_file="{{working_dir}}/${base_name}.html"
    output_file="{{working_dir}}/${base_name}.pdf"
    if [ -f "${input_file}" ]; then
        node "{{working_dir}}/html_2_pdf.js" "${input_file}" "${output_file}"
        if [ -f "${output_file}" ]; then
            echo "PDF created: $output_file"
            ls -l "$output_file"
        else
            echo "Failed to create PDF"
            exit 1
        fi
    else
        echo "Error: HTML file $input_file not found."
        exit 1
    fi

# Build HTML and convert to PDF
build-and-pdf FILE:
    just build {{FILE}}
    just html-to-pdf "$(basename "{{FILE}}" .md).html"


# Clean up generated files
clean FILE:
    #!/usr/bin/env bash
    echo "Cleaning up {{FILE}}..."
    base_name="$(basename "{{FILE}}" .md)"
    if [ -f "{{working_dir}}/$base_name.html" ]; then
        rm -f "{{working_dir}}/$base_name.html"
        echo "Deleted {{working_dir}}/$base_name.html."
    else
        echo "No HTML file to clean for {{FILE}}."
    fi
    if [ -f "{{working_dir}}/$base_name.pdf" ]; then
        rm -f "{{working_dir}}/$base_name.pdf"
        echo "Deleted {{working_dir}}/$base_name.pdf."
    else
        echo "No PDF file to clean for {{FILE}}."
    fi
    if [ -d "{{working_dir}}/node_modules" ]; then
        rm -rf "{{working_dir}}/node_modules"
        echo "Deleted node_modules directory."
    fi

# Build all Markdown files
build-all:
    #!/usr/bin/env bash
    echo "Building all Markdown files..."
    for file in {{working_dir}}/*.md; do
        just build "$file"
    done

# Clean all generated HTML and PDF files
clean-all:
    #!/usr/bin/env bash
    echo "Cleaning all generated HTML and PDF files..."
    find {{working_dir}} -name "*.html" -type f -delete
    find {{working_dir}} -name "*.pdf" -type f -delete
    echo "All HTML and PDF files deleted."
    if [ -d "{{working_dir}}/node_modules" ]; then
        rm -rf "{{working_dir}}/node_modules"
        echo "Deleted node_modules directory."
    fi

# Watch for changes and rebuild
watch:
    #!/usr/bin/env bash
    echo "Watching for changes in Markdown files..."
    while true; do
        inotifywait -e modify,create,delete -r {{working_dir}}
        just build-all
    done