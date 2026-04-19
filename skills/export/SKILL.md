# Skill: Export

Triggered by `/export [format]`. Makes the wiki portable.

---

## Available Formats

### `/export markdown` (always works — no dependencies)
Bundle all wiki pages into a single zip-ready directory with resolved links.
- Copy all wiki pages (excluding system files) into an `export/` directory
- Convert `[[wikilinks]]` to standard markdown links: `[page name](./path/to/page.md)`
- Include a table of contents generated from `_index.md`
- Output: `export/` directory ready to zip or import into other tools (Notion, etc.)

### `/export pdf` (requires: Python 3 + fpdf2)
Compile selected pages or the full wiki into a PDF.
- **First:** check if `fpdf2` is installed: `pip3 list | grep fpdf2`. If not, ask the user: "PDF export needs the fpdf2 Python package. Install it with `pip3 install fpdf2`?"
- Ask the user: "Full wiki or specific pages?"
- If specific: let them list pages
- Generate a single PDF with table of contents, page breaks between pages
- Output: `export/wiki-export-YYYY-MM-DD.pdf`

### `/export site` (no external dependencies — generates plain HTML)
Generate a simple static HTML site from the wiki.
- Convert each wiki page to HTML using basic markdown-to-HTML conversion (write a Python script or use inline text processing — do NOT require external packages)
- Resolve `[[wikilinks]]` to `<a href>` links
- Embed a minimal inline CSS theme (no external CSS files needed)
- Generate an index page from `_index.md`
- Output: `export/site/` directory with `index.html` and individual page HTMLs

---

## Rules

- Never export `raw/` contents — those are the user's private source material
- Never export system files (`_hot.md`, `_sources.md`) — those are operational
- Do export `_index.md` (as table of contents), `_disputed.md` (as part of the knowledge record)
- Ask before overwriting a previous export
