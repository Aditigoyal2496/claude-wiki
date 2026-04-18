---
title: "Hot Cache"
type: concept
status: active
created: 2026-04-18
last_updated: 2026-04-18
domain: technology
related:
  - llm-wiki-pattern   # the system this feature supports
  - compounding-knowledge   # prevents knowledge loss, enabling compounding
sources: []
certainty: high
---

# Hot Cache

A rolling context file (`_hot.md`) that persists recent session context between Claude Code sessions. Managed by session lifecycle hooks.

## How It Works

- **SessionStart hook** loads `_hot.md` — the agent immediately knows what happened in the last 2-3 sessions
- **SessionStop hook** writes a session summary to `_hot.md` and rolls older sessions off

The cache keeps a 3-session rolling window:
1. Current session (being populated)
2. Previous session
3. Two sessions ago

Older sessions roll off. This provides continuity without unbounded growth.

## Why 3 Sessions

- **1 session** is fragile — if a session crashes, context is lost
- **3 sessions** covers most "I was working on this yesterday/the day before" cases
- **Unlimited** would grow forever and eventually degrade query performance

## What Gets Cached

- What was ingested
- What was queried
- What pages were created or updated
- Open threads or unfinished tasks
- Key decisions or insights from the session

## Relationship to the Wiki

The hot cache is operational memory — it helps the agent orient quickly. The wiki is permanent memory — it stores knowledge durably. They serve different purposes and should not be conflated.
