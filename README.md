# dendrite

A self-organizing knowledge wiki powered by Claude Code + Obsidian. Drop sources in, the agent compiles and links everything, you read and query it in Obsidian. It gets smarter with every source you add.

Based on [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).

---

## Quickstart

```bash
git clone https://github.com/Aditigoyal2496/dendrite
cd claude-wiki
bash bin/setup-vault.sh
```

Open the folder as a vault in Obsidian. Then launch Claude Code:

```bash
claude
```

Type `/onboard` — the agent will ask you a few questions and build your first pages. Or drop a file into `raw/` and say `ingest it`.

That's it. You're running.

---

## How It Works

```
You drop sources into raw/ (articles, notes, books, meeting notes)
        ↓
The agent reads them and builds wiki pages — linked, structured, organized
        ↓
You ask questions — the agent searches the wiki and gives sourced answers
        ↓
/save files the conversation back into the wiki
        ↓
The wiki gets richer → better answers → more connections → repeat
```

You own `raw/`. The agent owns `wiki/`. You rarely edit wiki pages directly — the agent maintains everything.

---

## Commands

| Command | What It Does |
|---------|-------------|
| `/onboard` | First-run setup — the agent interviews you and creates starter pages |
| `/ingest [file]` | Read a source and extract knowledge into wiki pages |
| Just ask a question | The agent searches the wiki and gives you an answer with sources |
| `/save` | Save valuable parts of the conversation back into the wiki (run at end of session) |
| `/lint` | Health check — finds gaps, stale pages, contradictions |
| `/digest` | Weekly summary of what the wiki learned |
| `/autoresearch [topic]` | Web research on a topic, findings filed into the wiki |
| `/export markdown` | Export wiki as portable markdown (works everywhere) |
| `/export pdf` | Compile wiki into a PDF (needs Python + fpdf2) |
| `/export site` | Generate a static HTML site from the wiki |

---

## What Makes This Different

### The wiki knows what it doesn't know

Every page tracks how confident the agent is. Something directly from a source? High confidence. Something the agent inferred by connecting dots? Marked clearly as a guess. Over time, guesses either get confirmed by new sources or flagged for review.

### Sources disagree? Both sides get logged

When new information contradicts something already in the wiki, the agent doesn't silently overwrite. It logs both positions, explains its resolution, and adjusts confidence. You can see every disagreement in one place.

### Gaps are visible, not invisible

When a concept is mentioned but not fully documented, the agent creates a placeholder page. These show up in health checks and in the Obsidian graph as dangling nodes. Your wiki actively tells you what it still needs to learn.

### Different sources get different treatment

A journal entry and a research paper need different extraction. The agent knows that — journals get scanned for emotions, energy patterns, and recurring themes. Articles get their core argument, evidence, and counter-arguments. Books spawn multiple concept pages.

### It remembers across sessions

When you start a new session, the agent knows what you were working on last time. Open threads, unfinished questions, pages that were created — it picks up where you left off.

### Conversations compound

When you ask a question and get a useful answer, `/save` files it back into the wiki. That answer becomes source material for future questions. Every conversation makes the wiki smarter.

---

## What Goes Where

```
claude-wiki/
├── raw/                          # Your source material (you manage this)
│   ├── journals/                 # Journal entries, daily notes
│   ├── articles/                 # Web articles (use Obsidian Web Clipper)
│   ├── books/                    # Book highlights and notes
│   ├── voice/                    # Transcribed voice memos
│   ├── conversations/            # Meeting notes, chat exports
│   └── assets/                   # Images
├── wiki/                         # Agent-maintained (don't edit directly)
│   ├── goals/                    # One page per goal
│   ├── projects/                 # One page per project
│   ├── ideas/                    # Ideas and insights
│   ├── learnings/                # Lessons, concepts, skills
│   ├── concepts/                 # Definitions and frameworks
│   ├── health/                   # Habits, metrics, patterns
│   ├── people/                   # People across your sources
│   └── queries/                  # Saved answers, reports, digests
├── skills/                       # How the agent does each operation
├── _templates/                   # Obsidian templates for manual page creation
├── bin/setup-vault.sh            # One-time Obsidian setup
├── CLAUDE.md                     # Agent instructions (auto-loaded)
└── WIKI.md                       # Full schema reference
```

---

## Tips

- **Start small.** 5-10 sources is enough to see it working. Don't try to dump everything on day one.
- **Use [Obsidian Web Clipper](https://obsidian.md/clipper)** to send articles straight to `raw/articles/`. One click to capture, then `/ingest` to process.
- **Ask questions early.** Don't wait until the wiki is "big enough." Even 5 pages can surface connections you didn't notice.
- **Run `/save` before closing.** This is how the agent remembers what happened for next time.
- **Run `/digest` weekly.** A quick summary of what grew, what's missing, and what's worth revisiting.

---

## Obsidian Setup

The setup script configures:
- **Graph view** with color-coded nodes by page type
- **Templater** with auto-filling frontmatter templates
- **CSS snippets** for folder color-coding in the sidebar

**Recommended plugins to add:**
- [Obsidian Git](https://github.com/denolehov/obsidian-git) — auto-commits every 15 minutes
- [Web Clipper](https://obsidian.md/clipper) — send web articles to `raw/articles/`

---

## Inspiration

- [Andrej Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) — the pattern this is built on

---

## License

MIT
