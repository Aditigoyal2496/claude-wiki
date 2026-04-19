#!/usr/bin/env bash
# Injects hot cache into every prompt so the agent has session context.
# Registered as a UserPromptSubmit hook in .claude/settings.local.json

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
HOT_CACHE="$PROJECT_DIR/wiki/_hot.md"

if [ -f "$HOT_CACHE" ]; then
  # Read hot cache content, escape for JSON
  CONTEXT=$(cat "$HOT_CACHE" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null)

  if [ $? -eq 0 ] && [ -n "$CONTEXT" ]; then
    cat <<EOF
{
  "continue": true,
  "hookSpecificOutput": {
    "additionalContext": $CONTEXT
  }
}
EOF
    exit 0
  fi
fi

# Fallback — no hot cache or error reading it
echo '{"continue": true}'
exit 0
