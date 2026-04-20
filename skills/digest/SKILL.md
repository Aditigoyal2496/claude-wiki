# Skill: Digest

Triggered by `/digest`. Weekly summary + lightweight health check. This is where the deep linking and consistency work happens — ingest is fast, digest is thorough.

---

## Process

### Step 1: Determine Time Range

- Default: last 7 days
- If the user specifies a range: use that (e.g., `/digest this month`, `/digest last 2 weeks`)

### Step 2: Scan Activity

Read `wiki/_index.md` and scan all pages with `last_updated` dates within the range.

Collect:
- Pages created (with types and summaries)
- Pages updated (with what changed)
- Sources ingested

### Step 3: Lightweight Lint (Automatic)

This runs as part of every digest — the user doesn't need to run `/lint` separately unless they want a deep check.

**Cross-linking pass:**
- For each page created since the last digest, read it fully
- Check its `related:` links — are there connections it should have based on content that aren't listed?
- Add missing `related:` links with comments

**Stub creation:**
- Find concepts, people, or projects mentioned across 2+ pages but lacking their own page
- Create stub pages for them (`status: stub`, `certainty: inferred`)

**Certainty upgrades:**
- Check if any recently ingested source confirms something previously marked `certainty: inferred`
- If yes, upgrade to `high` and note the confirming source

**Contradiction check:**
- For pages with overlapping topics (shared `related:` links or domain), compare key claims
- If contradictions found, log in `wiki/_disputed.md`

**Stale pages:**
- Find pages where `last_updated` is older than 30 days with `status: active`
- Pick one to resurface

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

## New Pages
- [[page-name]] — one-line summary

## Updated Pages
- [[page-name]] — what changed

## Connections Added
- [[page-a]] ↔ [[page-b]] — [why they're connected]

## Stubs Created
- [[stub-name]] — appears in 2+ pages, needs its own page

## Certainty Changes
- [[page-name]] — upgraded from inferred to high (confirmed by [source])

## Contradictions Found
- [topic] — [brief summary and resolution]

## Resurface
- [[old-page]] — last touched X days ago. Still accurate?

## Open Questions
- Questions raised but unanswered
```

### Step 5: Nudge

If more than 5 sources have been ingested since the last digest, mention it:
"You've added X sources since the last health check. The wiki is growing — the connections above were found automatically. Run `/lint` for a deeper check if you want."

### Step 6: Update Bookkeeping

All of these must be completed:

1. **`wiki/_index.md`** — add the digest page to Queries & Outputs. Update page count. Add any new stubs to the Stubs section.
2. **`wiki/_log.md`** — append: digest summary with lint findings
3. **`wiki/_hot.md`** — update current session
