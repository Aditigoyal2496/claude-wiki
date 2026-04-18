# Skill: Onboard

Triggered by `/onboard` or automatically on first run when the wiki has 0 pages.

---

## Purpose

Get the user from empty wiki to populated wiki in under 10 minutes. Two tracks depending on whether they have source material ready.

---

## Detection

Check `wiki/_index.md` — if total pages is 0, this is a first run.

Check `raw/` subdirectories — are there any files?

---

## Track A: User Has Source Material

If files exist in any `raw/` subdirectory:

1. List the files found: "I see X files in raw/. Let me start with one to show you how this works."
2. Pick the first file (or let the user choose)
3. Run a full ingest (see `skills/ingest/SKILL.md`) with slightly more aggressive extraction:
   - Create 4-5 pages instead of the usual 2-3
   - Create more stubs for mentioned concepts
   - Generate at least 2 cross-links between new pages
4. Show the result: "Your wiki now has X pages. Here's what I extracted: [list with links]"
5. Ask: "Want me to ingest the rest, or would you like to explore what's here first?"

---

## Track B: No Source Material (Interview)

If `raw/` is empty:

1. Explain what's about to happen: "Let's build your starter wiki from a short conversation. I'll ask you a few questions — answer as much or as little as you want."

2. Ask these questions conversationally (not as a form — react to each answer before asking the next):

   **Q1:** "What do you do? What's your role, and what does a typical week look like?"
   → Generates: `people/me.md`

   **Q2:** "What are you working on right now — the 1-2 things taking most of your energy?"
   → Generates: 1-2 `projects/` or `goals/` pages

   **Q3:** "What's something you've been thinking about a lot lately — an idea, a problem, a question you keep coming back to?"
   → Generates: 1 `ideas/` page or `learnings/` page

   **Q4:** "What tools do you use daily? Where does your information live — Notion, Google Docs, Slack, Obsidian, something else?"
   → Informs future ingestion guidance (noted in `people/me.md`)

   **Q5:** "Is there anything you've been meaning to figure out or learn? A gap you've noticed?"
   → Generates: 1-2 stub pages in appropriate folders

3. After generating pages, show the result: "Your wiki has X pages now. Here's what we've got: [list with links]"

4. Guide next steps: "To grow the wiki, drop source files into the `raw/` folders — journal entries, articles, book highlights, meeting notes. Then tell me to ingest them."

---

## After Either Track

- Update `wiki/_index.md` with all new pages
- Append to `wiki/_log.md`: "Wiki initialized via onboarding"
- Update `wiki/_hot.md` with session context
- Ensure at least one cross-link exists between pages (the wiki should feel connected, not like isolated pages)
