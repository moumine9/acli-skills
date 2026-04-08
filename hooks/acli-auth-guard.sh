#!/usr/bin/env bash
# PostToolUse hook: detects acli authentication errors and injects context for Claude.

set -euo pipefail

input="$(cat)"

output="$(echo "$input" | jq -r '.output // ""')"

if echo "$output" | grep -qiE "(not logged in|401|unauthorized|authentication required|run acli jira auth login|please authenticate|no credentials|invalid token|token expired)"; then
  echo '{"additionalContext": "The last acli command failed with an authentication error. Ask the user if they want to authenticate now, then run the acli-auth skill (or suggest: acli jira auth login --web)."}'
  exit 0
fi

echo '{}'
exit 0
