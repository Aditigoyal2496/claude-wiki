# Skill: Autoresearch

Triggered by `/autoresearch [topic]`. Autonomous web research that files findings back into the wiki.

---

## Process

### Round 1: Search and Discover

1. Take the user's topic and formulate 3-5 search queries
   - Mix broad and specific queries
   - Include the topic + related terms from existing wiki pages
2. Run web searches
3. Identify the top 5-8 most relevant results
4. Read/fetch each result
5. Extract key findings, claims, and data

### Round 2: Cross-Reference with Wiki

1. Read existing wiki pages related to the topic
2. Compare web findings against existing wiki content
3. Identify:
   - **Confirmations** — web sources that confirm existing wiki claims (potential certainty upgrades)
   - **Contradictions** — web sources that conflict with existing wiki claims
   - **New information** — things not yet in the wiki
   - **Gap fills** — answers to existing stubs or open questions

### Round 3: Synthesize and File

1. Create or update wiki pages with findings
2. For each claim filed:
   - Set `certainty` based on source quality and corroboration
   - Add the web source to `sources:` (as a URL or description)
   - Mark web-sourced content clearly: `_[web research, YYYY-MM-DD]_`
3. Fill in any stubs that the research answered
4. Create new stubs for concepts discovered during research that need further investigation

### Output

Provide the user with:
- Summary of what was found
- Pages created or updated (with links)
- Stubs enriched
- New stubs created
- Contradictions with existing wiki content (if any)
- Confidence assessment: "How reliable are these findings?"

---

## Configuration

Edit `skills/autoresearch/references/program.md` to customize:
- Preferred source types (academic, official docs, news, etc.)
- Domains to prefer or avoid
- Maximum research rounds
- Confidence scoring rules

---

## Rules

- Always attribute web sources — never present web findings as established wiki knowledge without sourcing
- Prefer primary sources over summaries
- If findings conflict, present both sides rather than choosing one
- Do not research topics the user has marked as private or out of scope
- Web-sourced claims start at `certainty: medium` unless from highly authoritative sources
- Stubs created during research must have `status: stub` AND `certainty: inferred`
- Do NOT add `## Related` body sections that duplicate frontmatter `related:`

---

## Bookkeeping

All of these must be completed after research. Do not skip any:

1. **`wiki/_sources.md`** — add rows for each web source used, with pages created/updated
2. **`wiki/_index.md`** — add/update entries for all pages touched. Update page count. Add stubs to Stubs section.
3. **`wiki/_log.md`** — append: topic researched, sources found, pages created/updated, contradictions found
4. **`wiki/_hot.md`** — update current session with research activity
