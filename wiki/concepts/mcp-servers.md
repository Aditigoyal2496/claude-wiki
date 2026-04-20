---
title: "MCP servers"
type: concept
status: active
created: 2026-04-20
last_updated: 2026-04-20
domain: technology
related:
  - ai-native-pm-workflow      # MCP is the connective tissue of the workflow pattern
  - build-pm-ai-work-system    # required infrastructure for Aditi's goal
  - llm-wiki-pattern           # same family of LLM-as-glue patterns
sources: [raw/articles/pm-ai-work-system.md]
certainty: high
---

# MCP servers

**MCP** (Model Context Protocol) servers are connectors that let an LLM agent — like Claude Code — plug into external tools and data sources through a single, standardized interface. Instead of copy-pasting between tools, the agent reads from and writes to them directly.

## What the source PM connected via MCP

- Databases (production data)
- Notion
- Slack
- Gmail
- Granola (meeting notes)
- Metabase (dashboards/analytics)

> "Once you set it up it starts to feel like the tools are actually built around how you work rather than the other way around." — source article

## Why this matters for a PM

A PM's information is scattered: Jira, Slack, Docs, Sheets, a dozen other places (see [[me]]). MCP servers collapse that scatter into one interface the agent can reason across. This is the missing piece that made the source PM's workflow work — it wasn't the model, it was connecting the model to everything.

## Key property

Without MCP, a chat assistant is sealed off from the user's real context — every conversation starts fresh, nothing connects to production data. With MCP, the agent can query the actual databases, read the actual Slack threads, and produce outputs grounded in real state.

## See also

- [[ai-native-pm-workflow]] — the broader pattern MCP enables
- [[build-pm-ai-work-system]] — the goal that depends on this
