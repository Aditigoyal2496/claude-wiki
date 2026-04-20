---
title: "Personal-voice agent (/akash pattern)"
type: concept
status: active
created: 2026-04-20
last_updated: 2026-04-20
domain: technology
related:
  - ai-native-pm-workflow      # one of the patterns inside the broader workflow
  - build-pm-ai-work-system    # specific thing Aditi wants to replicate
  - compounding-knowledge      # the agent compounds as it reads more of your writing
sources: [raw/articles/pm-ai-work-system.md]
certainty: high
---

# Personal-voice agent

A pattern where you slowly train a reusable skill — in the source article, called `/akash` — on **your own way of thinking**: your analysis framework, how you structure decisions, how you frame things for different audiences.

When you're about to finalize something, you run it through the skill first, or ask it "what would I do here?"

> "It works out to something like having a second opinion from someone who has read everything you've written and paid attention to all of it." — source article

## What makes it distinct from a generic assistant

- It isn't prompted fresh each time — it accumulates your artifacts
- It isn't trying to be neutral — it's trying to sound like *you*
- The value is cumulative: the more you feed it, the more faithful the second opinion becomes

## Why this is interesting for a PM

A PM's output is mostly judgment expressed in prose: specs, proposals, tradeoff memos, stakeholder framings. A personal-voice agent is essentially a sparring partner that has internalized your judgment patterns. It catches sloppy reasoning before you ship, and reinforces consistency in how you communicate.

## Open questions

- How much writing do you need to feed it before the voice-matching crosses a usefulness threshold?
- Does the agent drift if you feed it work that isn't your best?
- Is the "second opinion" more valuable at draft stage or finalization stage?

## See also

- [[ai-native-pm-workflow]] — the broader workflow this pattern lives inside
