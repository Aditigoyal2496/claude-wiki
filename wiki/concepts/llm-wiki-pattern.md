---
title: "LLM Wiki Pattern"
type: concept
status: active
created: 2026-04-18
last_updated: 2026-04-18
domain: technology
related:
  - compounding-knowledge   # the underlying principle this pattern exploits
  - hot-cache               # implementation detail for session persistence
sources: []
certainty: high
---

# LLM Wiki Pattern

A knowledge management pattern where an LLM agent maintains a structured wiki from raw source material. The human curates sources; the LLM compiles, organizes, links, and maintains the wiki.

## How It Works

1. **Raw sources** (articles, notes, books, conversations) are collected in an immutable `raw/` directory
2. An **LLM agent** reads sources and "compiles" them into structured markdown pages in `wiki/`
3. Pages are **interlinked** with wikilinks, creating a knowledge graph
4. **Queries** against the wiki produce synthesized answers grounded in sources
5. Query outputs are **filed back** into the wiki, creating a compounding loop

## Origin

Described by Andrej Karpathy as a way to build personal knowledge bases for research topics. The key insight: LLMs are surprisingly good at maintaining index files, cross-references, and summaries — making fancy RAG unnecessary at moderate scale (~100 articles, ~400K words).

## Key Principles

- The LLM writes and maintains all wiki content — the human rarely touches it directly
- Raw sources are immutable — never modified by the LLM
- The wiki grows with every ingest and every query
- [[compounding-knowledge]] — each new source becomes more valuable because it connects to existing pages

## See Also

- [[hot-cache]] — session persistence for the wiki agent
- [[compounding-knowledge]] — the principle behind why this pattern works
