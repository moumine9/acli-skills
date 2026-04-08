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

Choose a scope when prompted:
- **User** — available in all your projects (recommended)
- **Project** — installs into `.claude/plugins/` for the whole team
- **Local** — project-scoped but only for you

Skills are available as:

- `/acli:auth`
- `/acli:search`
- `/acli:sprint`
- `/acli:workitem`

The auth guard hook activates automatically after install.

> **Note:** The official Anthropic marketplace includes an `atlassian` plugin that connects via MCP. This plugin is different: it wraps the `acli` CLI using skills, which load progressively and use far less context than MCP tool definitions loaded at session start.

## Test locally before installing

```bash
claude --plugin-dir ./
```

This loads the plugin from the current directory without installing it. Use `/reload-plugins` to pick up changes without restarting.

## Manual install

### Skills

Copy each skill directory into your Claude skills folder:

```bash
cp -r skills/auth ~/.claude/skills/
cp -r skills/search ~/.claude/skills/
cp -r skills/sprint ~/.claude/skills/
cp -r skills/workitem ~/.claude/skills/
```

Skills are then available as `/auth`, `/search`, `/sprint`, and `/workitem`.

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

## Reference docs

- [docs/commands.md](docs/commands.md) — all available commands at a glance
- [docs/reference.md](docs/reference.md) — full reference with flags and examples

### Skills

| Skill | Plugin trigger | Standalone trigger | Description | Auto-invoked |
|---|---|---|---|---|
| auth | `/acli:auth` | `/auth` | Login, logout, check status, or switch Jira and Confluence accounts | No |
| search | `/acli:search` | `/search` | Search work items by JQL, list projects, boards, filters, and dashboards | Yes |
| sprint | `/acli:sprint` | `/sprint` | List, create, and update sprints; show work items in a sprint | Yes |
| workitem | `/acli:workitem` | `/workitem` | Create, view, edit, transition, assign, comment, link, or clone issues | No |

Skills marked "No" use `disable-model-invocation: true` — Claude will not trigger them automatically. `acli-search` and `acli-sprint` are read-only and safe to auto-invoke.

### Hooks

| Hook | Trigger | What it does |
|---|---|---|
| acli-auth-guard.sh | PostToolUse + PostToolUseFailure (Bash) | Detects auth errors in `acli` output and injects context prompting Claude to offer re-authentication |

The hook uses an `if: "Bash(acli *)"` condition so it only spawns when an `acli` command is involved, not on every Bash call.

### Settings

`.claude/settings.local.json` contains pre-approved `allow` permissions for every `acli` subcommand the skills use, so Claude does not ask for confirmation on each run.
