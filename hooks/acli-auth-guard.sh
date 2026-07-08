#!/usr/bin/env bash
# PostToolUse hook: detects acli authentication errors and injects context for Claude.

set -euo pipefail

input="$(cat)"

# Extract .output — prefer jq, fall back to python, then to the raw JSON
if command -v jq >/dev/null 2>&1; then
  output="$(echo "$input" | jq -r '.output // ""')"
elif command -v python >/dev/null 2>&1 || command -v python3 >/dev/null 2>&1; then
  py="$(command -v python3 || command -v python)"
  output="$(echo "$input" | "$py" -c 'import sys,json; d=json.load(sys.stdin); print(d.get("output") or "")' 2>/dev/null || echo "$input")"
else
  output="$input"
fi

if echo "$output" | grep -qiE "(not logged in|401|unauthorized|authentication required|run acli jira auth login|please authenticate|no credentials|invalid token|token expired)"; then
  echo '{"additionalContext": "The last acli command failed with an authentication error. Ask the user if they want to authenticate now, then run the acli-auth skill (or suggest: acli jira auth login --web)."}'
  exit 0
fi

echo '{}'
exit 0
