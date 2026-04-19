#!/usr/bin/env bash
# Injects hot cache and index summary into the first prompt of each session.
# Registered as a UserPromptSubmit hook in .claude/settings.local.json

WIKI_DIR="$(dirname "$0")/../wiki"

# Hot cache — recent session context
if [ -f "$WIKI_DIR/_hot.md" ]; then
  echo "<wiki-context>"
  echo "## Recent Session Context"
  cat "$WIKI_DIR/_hot.md"
  echo ""
  echo "</wiki-context>"
fi
