# Skill: Save

Triggered by `/save` or `/save [name]`.

---

## Purpose

File the current conversation's valuable content back into the wiki. This closes the compounding loop — your explorations and Q&A sessions become source material for future queries.

---

## Process

### Step 1: Scan the Conversation

Review the full conversation and extract:
- **Decisions made** — anything the human decided or concluded
- **Insights surfaced** — new connections, realizations, or understanding
- **Questions raised** — unanswered questions worth tracking
- **Information learned** — facts, data, or context that wasn't in the wiki before
- **Corrections** — things the human corrected about existing wiki content

### Step 2: Quality Gate

If nothing worth filing was found:
- Say: "Nothing new to save from this session — the conversation was either routine or the insights are already in the wiki."
- Do not create empty or low-quality pages.

### Step 3: Deduplicate

For each piece of valuable content:
1. Check if it already exists on an existing wiki page
2. If **yes**: update that page instead of creating a new one
   - Add new information under a `## [YYYY-MM-DD] Update` section
   - Add this conversation as a source reference
3. If **no**: proceed to create a new page

### Step 4: Create/Update Pages

For new pages:
- Classify into the right page type (learning, idea, concept, goal, project, etc.)
- Use proper frontmatter from `WIKI.md`
- Set `certainty` based on how the content was derived:
  - Direct from human's statement → `high`
  - Synthesized during conversation → `medium`
  - Speculative connections discussed → `inferred`
- Add `related:` links to existing wiki pages with comments

For unanswered questions:
- Create stub pages if the question points to a concept worth tracking
- Or append to existing pages under an "Open Questions" section

### Step 5: Update Bookkeeping

- Update `wiki/_index.md`
- Append to `wiki/_log.md`: "Saved conversation: [summary of what was filed]"

### Step 6: Confirm

Show the human:
- Pages created (with links)
- Pages updated (with what was added)
- Stubs created (for open questions)

If `/save [name]` was used, use that name for the primary output page.

---

## What Never Gets Saved

- Debugging conversations (tool errors, retries, troubleshooting)
- Small talk or meta-conversation about the wiki itself
- Duplicate information already well-documented
- Raw conversation transcripts — always structure and distill
