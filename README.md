# claude-wiki

A self-organizing knowledge wiki powered by Claude Code. Drop sources in. The agent compiles, links, and maintains everything. You read it in Obsidian.

Based on [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), with improvements: certainty tracking, contradiction handling, stub pages for knowledge gaps, session persistence, and a compounding query loop.

---

## What It Does

**You** drop source material into `raw/` — articles, journal entries, book highlights, meeting notes, voice memos.

**The agent** reads every source and compiles a structured wiki:
- Extracts concepts, people, ideas, and learnings
- Cross-links everything with wikilinks
- Tracks what it's confident about vs. what it's guessing (`certainty: high | medium | inferred`)
- Logs contradictions between sources instead of silently overwriting
- Creates stubs for concepts mentioned but not yet documented
- Remembers context across sessions via a rolling hot cache

**You** ask questions against your growing knowledge base, and the answers get filed back — so every query makes the wiki smarter.

---

## What Makes This Different

| Feature | claude-wiki | Other wiki tools |
|---------|-------------|-----------------|
| **Certainty tracking** | Every page marks confidence level — `high`, `medium`, or `inferred`. Inferred content is flagged in the body. Lint surfaces aging inferences. | All content treated as equally true |
| **Contradiction handling** | Conflicts logged in `_disputed.md` with both positions and resolution. Never silently overwritten. | Silent overwrites or inline callouts |
| **Stub pages** | Mentioned-but-undocumented concepts become visible stubs. Lint tracks what needs enrichment. | Gaps are invisible |
| **Source-specific ingestion** | Different extraction rules for journals vs. articles vs. books vs. voice notes vs. conversations | All sources treated the same |
| **Hot cache** | Rolling 3-session context via hooks. Agent picks up where you left off. | No session memory |
| **Quality-gated `/save`** | Conversations filed back into wiki only if they add value. Deduplicates against existing pages. | Conversation dumps |
| **Belief evolution** | Certainty upgrades automatically when new sources confirm inferred claims | Static metadata |

---

## Quickstart

### 1. Clone and Setup

```bash
git clone https://github.com/your-username/claude-wiki
cd claude-wiki
bash bin/setup-vault.sh
```

### 2. Open in Obsidian

Open the `claude-wiki` folder as a vault in Obsidian. Install recommended plugins when prompted (Calendar, Templater).

### 3. Launch Claude Code

```bash
cd claude-wiki
claude
```

### 4. Get Started

**Option A — you have source material:**
Drop any file into `raw/articles/`, `raw/journals/`, `raw/books/`, etc. Then tell Claude:
```
ingest raw/articles/my-article.md
```

**Option B — starting from scratch:**
```
/onboard
```
The agent interviews you and generates starter pages from the conversation.

---

## Commands

| Command | What It Does |
|---------|-------------|
| `ingest [file]` | Read a source, extract knowledge, create/update wiki pages |
| `ingest all` | Batch process all files in `raw/` |
| Any question | Query the wiki — agent reads relevant pages and synthesizes an answer |
| `/lint` | Full health check — orphans, broken links, stale pages, contradictions |
| `/save` | File valuable parts of the conversation back into the wiki |
| `/save [name]` | Same, with a specific name for the output page |
| `/digest` | Weekly summary of wiki activity, growth, and gaps |
| `/autoresearch [topic]` | Web research on a topic, findings filed into wiki |
| `/export markdown` | Export wiki as portable markdown bundle |
| `/export pdf` | Compile wiki into a PDF |
| `/export site` | Generate a static HTML site from the wiki |
| `/onboard` | First-run setup — interview or first-ingest guided flow |

---

## Directory Structure

```
claude-wiki/
├── raw/                          # Your source material (immutable)
│   ├── journals/                 # Journal entries, daily notes
│   ├── articles/                 # Web articles (use Obsidian Web Clipper)
│   ├── books/                    # Book highlights and notes
│   ├── voice/                    # Transcribed voice memos
│   ├── conversations/            # Meeting notes, chat exports
│   └── assets/                   # Images referenced by sources
├── wiki/                         # Agent-maintained wiki
│   ├── _index.md                 # Master catalog (read first every session)
│   ├── _log.md                   # Append-only operations log
│   ├── _disputed.md              # Contradiction log
│   ├── _sources.md               # Source ingestion tracker
│   ├── _hot.md                   # Rolling session context (last 3 sessions)
│   ├── goals/                    # One page per goal
│   ├── projects/                 # One page per project
│   ├── ideas/                    # One page per idea or insight
│   ├── learnings/                # Concepts, lessons, skills
│   ├── concepts/                 # Domain definitions and frameworks
│   ├── health/                   # Habits, metrics, patterns
│   ├── people/                   # People across your sources
│   └── queries/                  # Filed query outputs, lint reports, digests
├── skills/                       # Modular skill definitions
│   ├── ingest/                   # Source ingestion
│   ├── query/                    # Answer synthesis
│   ├── lint/                     # Health checks
│   ├── save/                     # Conversation filing
│   ├── onboard/                  # First-run experience
│   ├── digest/                   # Weekly summaries
│   ├── autoresearch/             # Web research loop
│   └── export/                   # Portability
├── hooks/                        # Session lifecycle (hot cache)
├── _templates/                   # Obsidian Templater templates
├── bin/setup-vault.sh            # One-time Obsidian setup
├── CLAUDE.md                     # Agent operating manual
├── WIKI.md                       # Full schema reference
└── README.md                     # This file
```

---

## How It Works

### The Compounding Loop

```
Drop source into raw/
        ↓
Agent ingests → creates wiki pages, stubs, cross-links
        ↓
You query the wiki → agent synthesizes answers
        ↓
/save files the answer back into the wiki
        ↓
Wiki is richer → next query is better → next source connects to more
```

### Certainty Tracking

Every wiki page has a `certainty` field:

- **`high`** — directly stated in a source. The agent is confident.
- **`medium`** — synthesized from multiple sources. Reasonable but not explicit.
- **`inferred`** — the agent extrapolated. Marked clearly in the body with `_[inferred]_`.

When a new source confirms an inferred claim, certainty is automatically upgraded. Lint surfaces inferred claims older than 30 days that haven't been confirmed.

### Contradiction Handling

When sources disagree, the agent:
1. Does NOT silently overwrite the existing claim
2. Adds a `## Contradictions` section to the relevant page
3. Logs both positions in `_disputed.md` with the resolution
4. Downgrades certainty on affected claims

### Stub Pages

When the agent encounters a concept that's mentioned but not yet documented, it creates a **stub** — a minimal placeholder page marked `status: stub`. Stubs are:
- Visible in the index under "Stubs Needing Enrichment"
- Visible in the Obsidian graph as dangling nodes
- Automatically enriched when a relevant source is ingested
- Surfaced during `/lint` with suggestions for how to fill them

Stubs are your wiki's way of telling you what it doesn't know yet.

---

## Configuration

### Obsidian Plugins

**Included:**
- Templater (auto-fills frontmatter when creating pages)
- Calendar (sidebar calendar view)
- CSS snippets for folder color-coding

**Recommended:**
- Obsidian Git (auto-commit every 15 minutes)
- Web Clipper browser extension (send articles to `raw/articles/`)

### Autoresearch Settings

Edit `skills/autoresearch/references/program.md` to customize:
- Preferred source types and domains
- Confidence scoring rules
- Research depth limits

---

## Tips

- **Start small.** 5-10 sources is enough to see the pattern working. Don't try to dump 1000 documents on day one.
- **Use Obsidian Web Clipper** to send articles directly to `raw/articles/`. One click to capture, then `ingest` to process.
- **Ask questions early.** Don't wait until the wiki is "ready." Queries at 10 pages surface different insights than queries at 100 pages.
- **Run `/digest` weekly.** It shows you what the wiki learned and what it still needs.
- **Trust the stubs.** They're not failures — they're your wiki being honest about what it doesn't know yet.

---

## Inspiration

- [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [Second Brain with Claude Code](https://x.com/) (Mercury VP's workflow)
- [claude-obsidian](https://github.com/AgriciDaniel/claude-obsidian) by Agrici Daniel

---

## License

MIT
