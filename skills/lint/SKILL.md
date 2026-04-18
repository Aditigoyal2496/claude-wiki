# Skill: Lint

Triggered by `/lint`. Full health check across the entire wiki.

---

## Checks to Run

### 1. Orphan Pages
Find pages with no inbound `[[wikilinks]]` from other pages. These are disconnected from the knowledge graph.

**Action:** Suggest adding links from related pages, or ask if the page should be removed.

### 2. Broken Links
Find `[[wikilinks]]` that point to pages that don't exist.

**Action:** Either create a stub for the missing page or fix the link.

### 3. Stale Pages
Find pages where `last_updated` is older than 30 days AND the page has `status: active`.

**Action:** Surface for review: "[[page-name]] hasn't been touched in X days. Still accurate?"

### 4. Aging Inferred Content
Find pages with `certainty: inferred` that are older than 30 days and haven't been upgraded.

**Action:** Suggest either finding a source to confirm (upgrade to `high`) or marking the claim more clearly as speculative.

### 5. Missing Pages
Find concepts, people, or projects that are mentioned across 3+ pages but don't have their own page.

**Action:** Suggest creating a page for them.

### 6. Stubs Needing Enrichment
Find all `status: stub` pages. Check if any existing sources in `_sources.md` might cover the stub topic but weren't used.

**Action:** List stubs with suggestions for how to enrich them.

### 7. Cross-Page Contradictions
For pages with overlapping topics (identified via `related:` links and shared `domain:`):
- Compare key claims between related pages
- This is a **focused comparison**, not a full cross-product of all pages

**Action:** Log contradictions in `wiki/_disputed.md`. Add `## Contradictions` section to affected pages.

### 8. Source Coverage
Check `wiki/_sources.md` for:
- Sources that were ingested but produced no pages (suspicious)
- Pages that have no sources listed (may be entirely inferred)

**Action:** Flag for review.

### 9. Index Integrity
Verify that `wiki/_index.md` matches the actual pages on disk:
- Pages on disk but not in index
- Pages in index but not on disk

**Action:** Fix the index.

---

## Output

Generate `wiki/queries/lint-YYYY-MM-DD.md` with:

```yaml
---
title: "Lint Report — YYYY-MM-DD"
type: query
subtype: lint-report
created: YYYY-MM-DD
---
```

Body should contain:
- Summary stats (total pages, stubs, orphans, stale pages)
- Findings organized by check type
- Suggested actions for each finding
- Priority ranking: what to fix first

Also append a summary to `wiki/_log.md`.
