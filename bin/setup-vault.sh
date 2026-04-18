#!/usr/bin/env bash
# setup-vault.sh — Configure Obsidian vault for claude-wiki
# Run once after cloning: bash bin/setup-vault.sh

set -e

VAULT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OBSIDIAN_DIR="$VAULT_DIR/.obsidian"

echo "Setting up claude-wiki vault at: $VAULT_DIR"
echo ""

# --- Obsidian app config ---
mkdir -p "$OBSIDIAN_DIR"

# app.json — hide non-content folders from Obsidian
cat > "$OBSIDIAN_DIR/app.json" << 'EOF'
{
  "userIgnoreFilters": [
    "bin/",
    "hooks/",
    "skills/",
    "node_modules/"
  ],
  "showUnsupportedFiles": false,
  "newFileLocation": "folder",
  "newFileFolderPath": "wiki",
  "attachmentFolderPath": "raw/assets"
}
EOF
echo "✓ app.json — configured file locations and hidden folders"

# appearance.json — enable CSS snippets
cat > "$OBSIDIAN_DIR/appearance.json" << 'EOF'
{
  "enabledCssSnippets": [
    "vault-colors"
  ]
}
EOF
echo "✓ appearance.json — enabled vault-colors CSS snippet"

# graph.json — color-coded graph view
cat > "$OBSIDIAN_DIR/graph.json" << 'EOF'
{
  "collapse-filter": false,
  "search": "",
  "showTags": false,
  "showAttachments": false,
  "hideUnresolved": false,
  "showOrphans": true,
  "collapse-color-groups": false,
  "colorGroups": [
    { "query": "path:wiki/goals", "color": { "a": 1, "rgb": 52224 } },
    { "query": "path:wiki/projects", "color": { "a": 1, "rgb": 3381759 } },
    { "query": "path:wiki/learnings", "color": { "a": 1, "rgb": 16753920 } },
    { "query": "path:wiki/concepts", "color": { "a": 1, "rgb": 16776960 } },
    { "query": "path:wiki/ideas", "color": { "a": 1, "rgb": 11796480 } },
    { "query": "path:wiki/people", "color": { "a": 1, "rgb": 11751151 } },
    { "query": "path:wiki/health", "color": { "a": 1, "rgb": 5308416 } },
    { "query": "path:wiki/queries", "color": { "a": 1, "rgb": 8388736 } }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1,
  "lineSizeMultiplier": 1,
  "collapse-forces": true,
  "centerStrength": 0.5,
  "repelStrength": 10,
  "linkStrength": 1,
  "linkDistance": 250
}
EOF
echo "✓ graph.json — color-coded graph view configured"

# community-plugins.json — recommended plugins
cat > "$OBSIDIAN_DIR/community-plugins.json" << 'EOF'
[
  "calendar",
  "templater-obsidian"
]
EOF
echo "✓ community-plugins.json — Calendar and Templater recommended"

# templater config
mkdir -p "$OBSIDIAN_DIR/plugins/templater-obsidian"
cat > "$OBSIDIAN_DIR/plugins/templater-obsidian/data.json" << 'EOF'
{
  "templates_folder": "_templates",
  "trigger_on_file_creation": true,
  "auto_jump_to_cursor": true,
  "enable_system_commands": false,
  "enable_folder_templates": true,
  "folder_templates": [
    { "folder": "wiki/goals", "template": "_templates/goal.md" },
    { "folder": "wiki/projects", "template": "_templates/project.md" },
    { "folder": "wiki/ideas", "template": "_templates/idea.md" },
    { "folder": "wiki/learnings", "template": "_templates/learning.md" },
    { "folder": "wiki/concepts", "template": "_templates/concept.md" },
    { "folder": "wiki/health", "template": "_templates/health.md" },
    { "folder": "wiki/people", "template": "_templates/person.md" }
  ]
}
EOF
echo "✓ Templater — folder templates configured"

echo ""
echo "Setup complete. Next steps:"
echo "  1. Open this folder as a vault in Obsidian"
echo "  2. Install recommended community plugins (Calendar, Templater)"
echo "  3. Launch Claude Code in this directory"
echo "  4. Type /onboard to get started, or drop a file into raw/ and say 'ingest this'"
echo ""
