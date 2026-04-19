#!/usr/bin/env bash
# Injects hot cache into every prompt so the agent has session context.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
HOT_CACHE="$PROJECT_DIR/wiki/_hot.md"

if [ -f "$HOT_CACHE" ]; then
  CONTEXT=$(cat "$HOT_CACHE" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null)

  if [ $? -eq 0 ] && [ -n "$CONTEXT" ]; then
    cat <<EOF
{
  "continue": true,
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": $CONTEXT
  }
}
EOF
    exit 0
  fi
fi

echo '{"continue": true, "hookSpecificOutput": {"hookEventName": "UserPromptSubmit", "additionalContext": "No hot cache found."}}'
exit 0
