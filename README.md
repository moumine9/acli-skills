# acli

Claude Code skills and a hook for managing Jira from the terminal via the Atlassian CLI (`acli`).

## What's in here

Four skills cover the main Jira workflows: authenticating, searching issues and projects, viewing sprint data, and creating or editing work items. A PostToolUse hook watches for authentication errors and tells Claude to offer a fix. A `settings.local.json` file pre-approves the `acli` commands the skills use so you are not prompted on every run.

## Requirements

- `acli` (Atlassian CLI) installed
- Claude Code installed
- A Jira Cloud account

---

## Install acli

macOS:

```bash
brew install atlassian/tap/acli
```

Windows and Linux: download the binary from https://developer.atlassian.com/cloud/acli/

Verify the install:

```bash
acli --version
```

## Authenticate

You must authenticate before any `acli` command works.

OAuth login, which opens a browser window:

```bash
acli jira auth login --web
```

API token login, for CI or headless environments:

```bash
acli jira auth login --site "<your-site>.atlassian.net" --email "<email>" --token
```

Tokens are generated at https://id.atlassian.com/manage-profile/security/api-tokens. Paste or pipe the token when prompted.

Check the current session:

```bash
acli jira auth status
```

The `acli-auth-guard.sh` hook detects authentication errors in command output and injects context so Claude can prompt you to log in again.

---

## Plugin install (recommended)

Run these three commands inside any Claude Code session:

```
/plugin marketplace add moumine9/acli
/plugin install acli
/reload-plugins
```

Skills are available as:

- `/acli:acli-auth`
- `/acli:acli-search`
- `/acli:acli-sprint`
- `/acli:acli-workitem`

The auth guard hook activates automatically after install.

## Manual install

### Skills

Copy each skill directory into your Claude skills folder:

```bash
cp -r skills/acli-auth ~/.claude/skills/
cp -r skills/acli-search ~/.claude/skills/
cp -r skills/acli-sprint ~/.claude/skills/
cp -r skills/acli-workitem ~/.claude/skills/
```

Skills are then available as `/acli-auth`, `/acli-search`, `/acli-sprint`, and `/acli-workitem`.

### Auth guard hook

Copy the hook and make it executable:

```bash
cp hooks/acli-auth-guard.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/acli-auth-guard.sh
```

Add the following entry to `~/.claude/settings.json` under `hooks.PostToolUse`:

```json
{
  "matcher": "Bash",
  "hooks": [
    {
      "type": "command",
      "command": "bash \"${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/acli-auth-guard.sh\""
    }
  ]
}
```

### Project permissions

Copy `.claude/settings.local.json` into your project's `.claude/` folder:

```bash
cp .claude/settings.local.json <your-project>/.claude/settings.local.json
```

---

## Reference

### Skills

| Skill | Plugin trigger | Standalone trigger | Description |
|---|---|---|---|
| acli-auth | `/acli:acli-auth` | `/acli-auth` | Login, logout, check status, or switch Jira accounts |
| acli-search | `/acli:acli-search` | `/acli-search` | Search work items by JQL, list projects, and find boards |
| acli-sprint | `/acli:acli-sprint` | `/acli-sprint` | List sprints for a board and show work items in a sprint |
| acli-workitem | `/acli:acli-workitem` | `/acli-workitem` | Create, view, edit, transition, assign, or comment on issues |

### Hooks

| Hook | Trigger | What it does |
|---|---|---|
| acli-auth-guard.sh | PostToolUse (Bash) | Detects auth errors in `acli` output and injects context prompting Claude to offer re-authentication |

### Settings

`.claude/settings.local.json` contains pre-approved `allow` permissions for every `acli` subcommand the skills use, so Claude does not ask for confirmation on each run.
