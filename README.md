# acli

Claude Code skills and hooks for working with Jira via the Atlassian CLI (`acli`).

## What's in here

This repo has Claude Code skills for common Jira tasks (auth, search, sprints, work items), a PostToolUse hook that catches authentication errors and prompts you to re-authenticate, and a settings file with pre-approved acli command permissions. Install it as a plugin or copy the pieces you need manually.

## Prerequisites

- [acli](https://developer.atlassian.com/cloud/acli/) (Atlassian CLI) installed
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- A Jira Cloud account

## Install as a plugin (recommended)

Inside any Claude Code session:

```
/plugin marketplace add moumine9/acli
/plugin install acli
/reload-plugins
```

Skills are then available as:

- `/acli:acli-auth`
- `/acli:acli-search`
- `/acli:acli-sprint`
- `/acli:acli-workitem`

The auth guard hook activates automatically once the plugin is installed.

## 1. Install acli

macOS:
```bash
brew install atlassian/tap/acli
```

Windows / Linux: Download from https://developer.atlassian.com/cloud/acli/

Check install:
```bash
acli --version
```

## 2. Authenticate

Authentication is required before any acli command will work.

OAuth (recommended, opens a browser):
```bash
acli jira auth login --web
```

API token (for CI or headless environments):
```bash
acli jira auth login --site "<your-site>.atlassian.net" --email "<email>" --token
```

Tokens are created at https://id.atlassian.com/manage-profile/security/api-tokens

Check status:
```bash
acli jira auth status
```

The auth guard hook detects unauthenticated errors in command output and prompts you to run the auth skill.

## 3. Install skills

Copy the skills into your Claude config directory:
```bash
cp -r skills/acli-auth ~/.claude/skills/
cp -r skills/acli-search ~/.claude/skills/
cp -r skills/acli-sprint ~/.claude/skills/
cp -r skills/acli-workitem ~/.claude/skills/
```

Then use them in Claude Code with `/acli-auth`, `/acli-search`, `/acli-sprint`, `/acli-workitem`.

## 4. Install the auth guard hook

Copy the hook and make it executable:
```bash
cp hooks/acli-auth-guard.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/acli-auth-guard.sh
```

Then add the following to `~/.claude/settings.json` under `hooks.PostToolUse`:
```json
{
  "matcher": "Bash",
  "hooks": [{
    "type": "command",
    "command": "bash \"${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/acli-auth-guard.sh\""
  }]
}
```

## 5. Project-level permissions

Copy `.claude/settings.local.json` into your project's `.claude/` folder so Claude can run acli commands without approval prompts:
```bash
cp .claude/settings.local.json <your-project>/.claude/settings.local.json
```

## Skills

| Skill | Plugin trigger | Standalone trigger | Description |
|---|---|---|---|
| acli-auth | `/acli:acli-auth` | `/acli-auth` | Login, logout, check status, or switch Jira accounts |
| acli-search | `/acli:acli-search` | `/acli-search` | Search work items, list projects, find boards via JQL |
| acli-sprint | `/acli:acli-sprint` | `/acli-sprint` | List sprints and work items in a sprint |
| acli-workitem | `/acli:acli-workitem` | `/acli-workitem` | Create, edit, view, transition, assign, or comment on Jira issues |

## Hooks

| Hook | Trigger | What it does |
|---|---|---|
| acli-auth-guard.sh | PostToolUse (Bash) | Detects auth errors in acli output and tells Claude to suggest authentication |

## Settings

`.claude/settings.local.json` has pre-approved permissions for all acli subcommands used by the skills. Copy it into any project where you want Claude to run acli commands without asking for confirmation each time.
