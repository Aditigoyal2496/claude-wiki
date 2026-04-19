# Skill: Ingest

Triggered when the user provides a source to ingest (a file in `raw/`, a pasted article, or a URL).

---

## Process

### Step 1: Identify and Validate Source

- Determine source type from location or content: journal, article, book, voice note, conversation
- Check `wiki/_sources.md` — has this source been ingested before?
  - If **yes**: treat as an update. Read existing pages that reference this source and update them with new information. Do not create duplicate pages.
  - If **no**: proceed with fresh ingestion.

### Step 2: Read Source Fully

- Read the entire source document
- Do not skim or sample — read it all

### Step 3: Extract Based on Source Type

Apply source-specific extraction rules (see `WIKI.md` for details):

**Journals** — Extract:
- Emotions and energy patterns
- Progress on goals (link to existing goal pages if they exist)
- Recurring themes across entries
- People mentioned
- Signals the human may not have noticed themselves
- Do NOT just summarize the day

**Articles** — Extract:
- Core argument and thesis
- Evidence cited
- Connections to existing wiki concepts
- Counter-arguments or limitations mentioned
- Author as a `people/` page if significant

**Books** — Extract:
- Key concepts as `learnings/` or `concepts/` pages (a single book may spawn 3-8 pages)
- Author as a `people/` page
- Link concepts together
- Note which highlights are the human's own annotations vs. the author's words

**Voice Notes** — Extract:
- Treat like journals but expect messier structure
- Pull out the clearest signal
- Note if something seems said in emotion vs. deliberate reflection

**Conversations** — Extract:
- Decisions made
- Commitments given or received
- Ideas surfaced
- Tensions or unresolved questions
- People mentioned may warrant `people/` pages

### Step 4: Create and Update Pages

For each extracted concept, entity, or insight:

1. **Check if a page already exists** — search `_index.md` for the topic
2. **If page exists**: update it
   - Add the new source to `sources:` frontmatter
   - Update `last_updated`
   - Add new information under a `## [YYYY-MM-DD] Update` section
   - Never silently overwrite existing content
3. **If no page exists**: create one
   - Use the appropriate frontmatter schema from `WIKI.md`
   - Set `certainty` honestly
   - Add `related:` links with comments explaining why
   - Do NOT add a `## Related` body section that duplicates frontmatter — frontmatter `related:` is canonical
4. **If a concept is mentioned but you can't document it fully**: create a **stub**
   - Set `status: stub`
   - Set `certainty: inferred`
   - Add `mentioned_in:` with the source that referenced it
   - Mark in body: `_This is a stub. Mentioned in [[source-page]] but not yet documented._`

### Step 5: Certainty Upgrades

Check all pages touched or related to the new content:
- If a new source directly confirms something previously marked `certainty: inferred`, upgrade to `high`
- Log the upgrade in `_log.md`

### Step 6: Lightweight Lint (Automatic)

For the pages you just created or updated:
- Check for broken `[[wikilinks]]` — do the linked pages exist?
- Compare new claims against related pages for contradictions
  - This is a **focused check** — compare this specific new content against the 3-5 most related pages
  - Not a full-wiki scan
- If contradictions found:
  - Add a `## Contradictions` section to the relevant page
  - Log in `wiki/_disputed.md` with both positions and your resolution
  - Set affected claims to `certainty: medium` or `inferred`

### Step 7: Update Bookkeeping

All of these must be updated after every ingest:

1. **`wiki/_sources.md`** — add a row: source path, date ingested, pages created, pages updated
2. **`wiki/_index.md`** — add/update entries for all pages touched. Update total page count.
3. **`wiki/_log.md`** — append an entry describing what was ingested, pages created, pages updated, contradictions found (if any)
4. **`wiki/_hot.md`** — update the "Current Session" section with ingest activity

### Step 8: Brief the Human

After ingestion, provide a short summary:
- Pages created (with links)
- Pages updated (with what changed)
- Stubs created (gaps identified)
- Contradictions found (if any)
- Certainty upgrades (if any)
- One interesting connection or insight you noticed during ingestion

---

## Batch Ingestion

When the user says "ingest all of these" or points to multiple files:

1. List all files to be ingested
2. Process each one sequentially (not in parallel — order matters for cross-referencing)
3. After each individual ingest, check if it connects to previously ingested sources in this batch
4. At the end, provide a batch summary
