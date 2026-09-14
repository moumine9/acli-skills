# Changelog

All notable changes to the `acli-skills` plugin are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.1] - 2026-09-14

### Added

- `docs/acli-help.txt`: full `acli --help` tree from `acli` 1.3.36-stable, committed as the baseline for detecting CLI changes on future upgrades.
- `scripts/dump-help.sh`: regenerates that dump.
- Project-local `update-acli-docs` maintainer skill (`.claude/skills/`, not exposed as a plugin skill): upgrade acli, diff the help tree, update the docs.
- `CHANGELOG.md`, following Keep a Changelog 1.1.0, with history reconstructed from git.

### Changed

- Docs checked against `acli` 1.3.36-stable. Help output is identical to 1.3.23-stable (no command or flag changes), and every 1.3.36 leaf command is listed in `docs/commands.md`. No skill changes needed. `rovodev` subcommands were not re-checked: rovodev is a separately versioned plugin downloaded on first use.
- README documents the `atlassian-document-format` skill (plugin and standalone triggers, manual install, skills table).

## [1.1.0] - 2026-08-18

### Added

- `atlassian-document-format` skill: converts Markdown into Atlassian Document Format (ADF) JSON for use with Jira descriptions/comments (`--description-file`, `--body-file`) and, where supported, Confluence page bodies.
- `.claude-plugin/marketplace.json` using the standard Claude Code marketplace schema, so the repo can be added with `/plugin marketplace add moumine9/acli-skills`.
- MIT `LICENSE` file, matching the license already declared in `plugin.json`.
- README "Integrations" section describing how the `plan-realisation-fe` skill uses `workitem view` to pull Jira ticket context.

### Changed

- **Plugin renamed from `acli` to `acli-skills`** (GitHub repo `moumine9/acli` → `moumine9/acli-skills`). Skill triggers move from `/acli:<skill>` to `/acli-skills:<skill>`.
- `docs/commands.md` and `docs/reference.md` refreshed against `acli` 1.3.22-stable:
  - New top-level commands: `guard` (separate plugin), `feedback`, `completion`.
  - New `jira board view`, `jira filter view`, `jira filter list-columns`, `jira field restore`, and `jira workitem list-watchers`. They replace `board get`, `filter get`, `filter get-columns`, `field cancel-delete`, and `workitem watcher list`, which are now marked deprecated.
  - New `rovodev` subcommands: `oauth`, `config`, `log`, `mcp`, `serve`, `acp`, `lsp`, `legacy`, `doctor`.
- README command count updated from 90 to 106.

### Fixed

- `acli-auth-guard.sh` no longer fails with `jq: command not found`. It reads the tool output with `jq` when available, then falls back to `python`, then to pattern-matching the raw hook input.

## [1.0.0] - 2026-04-08

### Added

- `auth`, `search`, `sprint`, and `workitem` skills for managing Jira from the terminal via `acli`, available as `/acli:<skill>`. `auth` and `workitem` set `disable-model-invocation: true` so they only run when the user asks; the read-only `search` and `sprint` can be auto-invoked.
- `hooks/acli-auth-guard.sh`: detects `acli` authentication errors and prompts Claude to offer re-authentication. It is wired through `hooks/hooks.json` on `PostToolUse` and `PostToolUseFailure` and runs only for `Bash(acli *)` calls.
- `.claude-plugin/plugin.json` for installing the repo as a Claude Code plugin.
- `docs/reference.md`: full `acli` reference built from local `--help` output, covering Jira, Confluence, admin, and Rovo Dev commands. Corrects several errors in the official docs, such as `jira field` having no `list` command and `jira dashboard` using `search`.
- `docs/commands.md`: quick-reference table of all commands.
- `.claude/settings.local.json` with pre-approved `acli` permissions, and a `.gitignore` that keeps tokens and credentials out of the repo.
- README covering acli install, authentication, plugin and manual installation, and local testing with `claude --plugin-dir ./`.

[unreleased]: https://github.com/moumine9/acli-skills/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/moumine9/acli-skills/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/moumine9/acli-skills/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/moumine9/acli-skills/releases/tag/v1.0.0
