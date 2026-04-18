# Skill: Query

Triggered when the user asks a question about their knowledge base.

---

## Process

### Step 1: Search the Wiki

1. Read `wiki/_index.md` to find relevant pages
2. Identify all pages that could inform the answer — check by topic, related links, and domain
3. Read those pages in full

### Step 2: Assess Certainty

Before synthesizing:
- Note which pages are `certainty: high` vs. `medium` vs. `inferred`
- Note which pages are stubs (incomplete information)

### Step 3: Synthesize Answer

Compose an answer with:
- Inline `[[wikilinks]]` to every wiki page referenced
- Clear distinction between what sources say and what you're inferring
- If the answer relies heavily on `inferred` content, flag it: "Note: this answer draws on inferred connections — consider adding sources to strengthen these claims."
- If relevant stubs exist, mention them: "There's a stub for [[concept]] that could help answer this more fully if enriched."

### Step 4: Choose Output Format

Match the format to the question type:
- **General questions**: Markdown answer with wikilinks
- **Comparisons**: Table
- **Patterns over time**: Dated list with timeline
- **Recommendations**: Prioritized list with reasoning
- **"What do I know about X?"**: Comprehensive summary pulling from all related pages

### Step 5: Offer to File

If the answer is non-trivial (required reading 3+ pages or produced novel synthesis):
- Ask: "This answer connects several pages. Should I file it in `wiki/queries/`?"
- If yes: create a page with `type: query` frontmatter, link it in `_index.md`

### Step 6: Update Bookkeeping

- Append to `wiki/_log.md`: what was asked, which pages were consulted
- Update `wiki/_hot.md` current session with the query topic
