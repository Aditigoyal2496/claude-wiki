# Skill: Export

Triggered by `/export [format]`. Makes the wiki portable.

---

## Available Formats

### `/export markdown`
Bundle all wiki pages into a single zip-ready directory with resolved links.
- Copy all wiki pages (excluding system files) into an `export/` directory
- Convert `[[wikilinks]]` to standard markdown links: `[page name](./path/to/page.md)`
- Include a table of contents generated from `_index.md`
- Output: `export/` directory ready to zip or import into other tools (Notion, etc.)

### `/export pdf`
Compile selected pages or the full wiki into a PDF.
- Ask the user: "Full wiki or specific pages?"
- If specific: let them list pages
- Generate a single PDF with table of contents, page breaks between pages, and working internal links
- Output: `export/wiki-export-YYYY-MM-DD.pdf`

### `/export site`
Generate a simple static HTML site from the wiki.
- Convert each wiki page to HTML
- Resolve `[[wikilinks]]` to `<a href>` links
- Apply a minimal, readable CSS theme
- Generate an index page from `_index.md`
- Output: `export/site/` directory with `index.html` and individual page HTMLs

---

## Rules

- Never export `raw/` contents — those are the user's private source material
- Never export system files (`_hot.md`, `_sources.md`) — those are operational
- Do export `_index.md` (as table of contents), `_disputed.md` (as part of the knowledge record)
- Ask before overwriting a previous export
