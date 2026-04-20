# Skill: Ingest

Triggered when the user provides a source to ingest. Sources can arrive in three ways:

1. **File path** — user points to a file in `raw/` (e.g., "ingest raw/articles/my-article.md")
2. **Pasted content** — user pastes text directly in chat (e.g., an article, notes, highlights)
3. **URL** — user provides a web link to fetch and ingest

**Design principle:** Ingest is fast. Read the source, create the pages, update the index. Deep cross-linking, contradiction checks, and certainty upgrades happen during `/lint` or `/digest`, not here.

---

## Process

### Step 1: Save Source to raw/

- If **file already in raw/**: proceed
- If **pasted content**: save to the appropriate `raw/` subdirectory (e.g., `raw/articles/article-title.md`) with basic frontmatter (source_type, date, attribution)
- If **URL**: fetch the content, save to `raw/articles/`

Every ingested source must have a file in `raw/` for traceability.

### Step 2: Read Source + Index

Two reads only:
1. Read the source document fully
2. Read `wiki/_index.md` to know what already exists

Do NOT read individual wiki pages at this step. The index summaries are enough to determine what exists and what's new.

### Step 3: Extract the Core

**Keep it focused.** One source usually produces **one main page** and maybe updates to 1-2 existing pages. Don't over-extract.

Source-specific extraction rules:

**Articles** — One page for the core argument. Add `related:` links to existing pages based on index summaries. If the author is significant, note them in `related:` — a people page can be created during lint if they appear in 2+ sources.

**Journals** — One page per entry (or per batch if multiple entries). Extract: emotions, energy, goal progress, recurring themes. Look for signals the human may not notice.

**Books** — This is the exception to "one page." Books can produce 2-4 pages for distinct concepts. But don't create a page for every highlight — group related highlights into one concept page.

**Voice notes** — One page. Pull the clearest signal. Note if something seems emotional vs. deliberate.

**Conversations** — One page. Extract: decisions, commitments, ideas, unresolved tensions.

### Step 4: Smart Match — Check for Obvious Overlaps

Scan `_index.md` summaries. If a new concept clearly overlaps with an existing page (same topic, same person, same project):

- **Read that one existing page** (only that one)
- **Update it** instead of creating a new page
- Add the new source to `sources:` frontmatter
- Update `last_updated`
- Add new information under a `## [YYYY-MM-DD] Update` section

If no obvious overlap exists in the index → create a new page. Don't read existing pages "just to check."

### Step 5: Create New Pages

For genuinely new concepts:
- Use the appropriate frontmatter schema from `WIKI.md`
- Set `certainty` honestly
- Add `related:` links based on index summaries (you don't need to read the full pages to know they're related)
- Do NOT add a `## Related` body section that duplicates frontmatter
- **Do NOT create stubs during ingest.** Note missing concepts in the page body or `related:` comments. Stubs are created during `/lint` when a concept appears across 2+ pages.

### Step 6: Update Index

Update `wiki/_index.md`:
- Add entries for new pages
- Update entries for modified pages
- Update total page count
- **Write keyword-rich summaries** — these are the primary discovery mechanism for queries. "8-step eval methodology — failure-first rubrics, golden datasets, AI judges" is better than "Evaluation methodology."

This is the only system file you must update during ingest.

### Step 7: Brief the Human

Short summary:
- Pages created (with names)
- Pages updated (with what changed)
- Connections noticed (based on index, not deep reads)

Keep it concise. Don't list every frontmatter field you set.

---

## What Ingest Does NOT Do

These happen in other operations, not during ingest:

| Work | When It Happens |
|------|----------------|
| Deep cross-linking between pages | `/lint` |
| Contradiction checking | `/lint` |
| Certainty upgrades (inferred → high) | `/lint` |
| Creating stub pages | `/lint` (when a concept appears in 2+ pages) |
| Updating `_log.md` | `/save` |
| Updating `_hot.md` | `/save` |
| Updating `_sources.md` | `/save` |

---

## Batch Ingestion

When the user says "ingest all of these" or points to multiple files:

1. List all files to be ingested
2. Sort by date if available (oldest first), otherwise alphabetical
3. Process each one using the fast path above
4. At the end, provide a batch summary: X sources ingested, Y pages created, Z pages updated

---

## User Override

The user's instructions always take priority. If they say "read the full pages and do deep linking" — do it. If they say "just save it, don't create any pages" — do that. Acknowledge what you're doing differently.
