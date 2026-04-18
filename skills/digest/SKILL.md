# Skill: Digest

Triggered by `/digest`. Generates a summary of wiki activity.

---

## Process

### Step 1: Determine Time Range

- Default: last 7 days
- If the user specifies a range: use that (e.g., `/digest this month`, `/digest last 2 weeks`)

### Step 2: Scan Activity

Read `wiki/_log.md` for entries within the time range. Also scan all pages for `last_updated` dates within the range.

Collect:
- Pages created (with types and summaries)
- Pages updated (with what changed)
- Stubs created (gaps identified)
- Contradictions found and resolutions
- Certainty upgrades or downgrades
- Sources ingested

### Step 3: Find One Page to Resurface

Search for the page with the oldest `last_updated` that:
- Has `status: active` (not stub, not completed, not abandoned)
- Has at least one `related:` link to an active page
- Has NOT been resurfaced in a previous digest within the last 30 days

### Step 4: Generate Digest

Create `wiki/queries/digest-YYYY-MM-DD.md`:

```yaml
---
title: "Digest — YYYY-MM-DD"
type: query
subtype: digest
created: YYYY-MM-DD
---
```

Body:

```markdown
# Wiki Digest — [date range]

## Stats
- Total pages: X (up from Y)
- Sources ingested: N
- Stubs awaiting enrichment: N

## New Pages
- [[page-name]] — one-line summary

## Updated Pages
- [[page-name]] — what changed

## Stubs Created
- [[stub-name]] — mentioned in [[source]], needs enrichment

## Contradictions
- [topic] — [brief summary of conflict and resolution]

## Certainty Changes
- [[page-name]] — upgraded from inferred to high (confirmed by [source])

## Resurface
- [[old-page]] — last touched X days ago. Still accurate? Any new connections?

## Open Questions
- Questions that were raised but remain unanswered
```

### Step 5: Update Bookkeeping

- Add digest to `wiki/_index.md` under Queries & Outputs
- Append to `wiki/_log.md`
