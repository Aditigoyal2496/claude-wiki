---
title: "Compounding Knowledge"
type: concept
status: active
created: 2026-04-18
last_updated: 2026-04-18
domain: productivity
related:
  - llm-wiki-pattern   # the system that enables compounding
  - hot-cache           # persistence that prevents knowledge loss between sessions
sources: []
certainty: high
---

# Compounding Knowledge

The principle that knowledge becomes more valuable as it connects to other knowledge. Each new source added to a wiki is more useful than the last because it links to and enriches existing pages.

## How It Works in Practice

- Source #1 creates 3 standalone pages
- Source #5 creates 2 new pages and updates 3 existing ones — those updates make all 5 pages richer
- Source #20 might not create any new pages at all, but deepens and cross-links 8 existing ones
- By source #50, even a simple query draws from dozens of interconnected pages

## Why It Matters

Most knowledge systems are additive — each note is independent. A compounding system is multiplicative — each note makes every other note more valuable.

This is why the [[llm-wiki-pattern]] files query outputs back into the wiki. Every question you ask and answer becomes part of the knowledge base for future questions.

## The Cold Start Problem

Compounding requires a critical mass. The first 5-10 sources feel underwhelming because there's nothing to connect to. The system starts to feel "alive" around 20-30 sources, when cross-links become dense enough that queries return surprisingly rich answers.

Patience through the cold start is essential. The value curve is exponential, not linear.
