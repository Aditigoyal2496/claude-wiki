#!/usr/bin/env bash
# Fires on Stop event — reminds the agent to save session context.
# Stop hooks only use top-level fields, no hookSpecificOutput needed.

cat <<'EOF'
{
  "continue": true,
  "stopReason": "Session ending — update wiki/_hot.md with a session summary if /save was not run."
}
EOF
exit 0
