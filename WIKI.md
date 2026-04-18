# WIKI.md — Schema Reference

Full specification for all page types, frontmatter fields, and system files.

---

## Page Type Schemas

### Goals
```yaml
---
title: "Goal name"
type: goal
status: active | paused | completed | abandoned
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
horizon: short | medium | long
related:
  - project-slug    # why this is related
sources: [raw/journals/entry.md]
certainty: high | medium | inferred
---
```

### Projects
```yaml
---
title: "Project name"
type: project
status: active | paused | completed | abandoned | stub
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
goal: goal-slug
related:
  - idea-slug       # why this is related
sources: [raw/conversations/meeting.md]
certainty: high | medium | inferred
---
```

### Ideas
```yaml
---
title: "Idea title"
type: idea
status: active | stub
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
strength: emerging | developed | foundational
related:
  - goal-slug       # why this is related
sources: [raw/books/book-name.md]
certainty: high | medium | inferred
---
```

### Health
```yaml
---
title: "Habit or health topic"
type: health
subtype: habit | metric | pattern | observation
status: active | stub
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
related:
  - goal-slug       # why this is related
sources: [raw/journals/entry.md]
certainty: high | medium | inferred
---
```

### Learnings
```yaml
---
title: "Concept or lesson"
type: learning
status: active | stub
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
domain: productivity | psychology | health | craft | relationships | finance | technology | other
related:
  - idea-slug       # why this is related
sources: [raw/books/book-name.md, raw/articles/article.md]
certainty: high | medium | inferred
---
```

### People
```yaml
---
title: "Person name"
type: person
status: active | stub
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
relationship: self | author | mentor | friend | colleague | thinker
related:
  - learning-slug   # why this is related
sources: [raw/books/their-book.md]
certainty: high | medium | inferred
---
```

### Concepts
```yaml
---
title: "Concept name"
type: concept
status: active | stub
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
domain: same as learnings
related:
  - learning-slug   # why this is related
sources: [raw/articles/article.md]
certainty: high | medium | inferred
---
```

### Queries (filed outputs)
```yaml
---
title: "Question or report title"
type: query
subtype: answer | lint-report | digest | research
created: YYYY-MM-DD
related:
  - page-slug       # pages referenced in the answer
sources: []
---
```

---

## System Files

### `_index.md`
Master catalog. One-line summary of every page, organized by type. Tables with columns: Page, Summary, Status/Strength, Last Updated.

Updated after every operation that creates or modifies pages.

### `_log.md`
Append-only chronological log. Format:
```markdown
## [YYYY-MM-DD] operation | description
Details of what was done, pages created/updated.
```
Never delete entries.

### `_disputed.md`
Contradiction log. Format:
```markdown
## [YYYY-MM-DD] Contradiction: topic
**Claim A:** [what page X says] (source: ...)
**Claim B:** [what page Y says] (source: ...)
**Resolution:** [how the agent resolved it]
**Action taken:** [what was updated]
```

### `_sources.md`
Source ingestion tracking. Format:
```markdown
| Source | Ingested | Pages Created | Pages Updated |
|--------|----------|---------------|---------------|
| raw/articles/example.md | YYYY-MM-DD | page-a, page-b | page-c |
```
Used to check "has this source been ingested before?" and to trace which sources influenced which pages.

### `_hot.md`
Rolling session context cache. Keeps last 3 sessions. Format:
```markdown
## Current Session
(populated during active session)

## Previous Session (YYYY-MM-DD)
- Summary of what happened
- Key pages touched
- Open threads

## Two Sessions Ago (YYYY-MM-DD)
- Summary
```
Managed by session hooks. Older sessions roll off.

---

## Field Definitions

### `certainty`
| Value | Meaning | Agent behavior |
|-------|---------|----------------|
| `high` | Directly stated in source | Weight heavily in query answers |
| `medium` | Synthesized from multiple sources | Use but note the synthesis |
| `inferred` | Extrapolated or gap-filled | Flag in body with `_[inferred]_`, surface in lint after 30 days |

### `status`
| Value | Meaning |
|-------|---------|
| `active` | Currently relevant and maintained |
| `paused` | Temporarily on hold |
| `completed` | Done, kept for reference |
| `abandoned` | Stopped, kept for learning |
| `stub` | Placeholder — mentioned in a source but not yet documented |

### `strength` (ideas only)
| Value | Meaning |
|-------|---------|
| `emerging` | Just surfaced, needs more evidence |
| `developed` | Supported by multiple sources |
| `foundational` | Core belief or framework |

### `horizon` (goals only)
| Value | Meaning |
|-------|---------|
| `short` | Days to weeks |
| `medium` | Weeks to months |
| `long` | Months to years |

---

## Naming Conventions

- Lowercase kebab-case: `learn-to-focus.md`, `eval-playbook.md`
- Be specific: `run-5k-by-june.md` not `goal-health.md`
- People: `andrej-karpathy.md` not `karpathy.md`
- Concepts: `retrieval-augmented-generation.md` not `rag.md`

---

## Source-Specific Ingestion Rules

| Source Type | Location | Extract |
|-------------|----------|---------|
| **Journals** | `raw/journals/` | Emotions, energy patterns, goal progress, recurring themes, people mentioned. Look for signals the human may not notice. |
| **Articles** | `raw/articles/` | Core argument, evidence cited, connections to existing concepts, counter-arguments. |
| **Books** | `raw/books/` | Key concepts as `learnings/` pages, author as `people/` page. A single book may spawn 3-8 pages. |
| **Voice notes** | `raw/voice/` | Treat like journals but expect messier structure. Pull clearest signal. Note emotional vs. deliberate. |
| **Conversations** | `raw/conversations/` | Decisions made, commitments, ideas surfaced, tensions, unresolved questions. People → `people/` pages. |
