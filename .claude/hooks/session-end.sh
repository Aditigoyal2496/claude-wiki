#!/usr/bin/env bash
# Fires on Stop event — reminds the agent to save session context.

cat <<'EOF'
{
  "continue": true,
  "hookSpecificOutput": {
    "hookEventName": "Stop"
  },
  "systemMessage": "Session is ending. If you have not run /save this session, update wiki/_hot.md now with a summary of what happened: pages created/updated, open threads, and anything that should carry over to the next session."
}
EOF
exit 0
