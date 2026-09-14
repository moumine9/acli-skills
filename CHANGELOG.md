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

### Changed

- Docs checked against `acli` 1.3.36-stable. Help output is identical to 1.3.23-stable (no command or flag changes), and every 1.3.36 leaf command is listed in `docs/commands.md`. No skill changes needed. `rovodev` subcommands were not re-checked: rovodev is a separately versioned plugin downloaded on first use.
- `CHANGELOG.md` now follows Keep a Changelog 1.1.0 (`Unreleased` section and version comparison links).

## [1.1.0] - 2026-08-18

### Added

- `atlassian-document-format` skill: converts Markdown into Atlassian Document Format (ADF) JSON for use with Jira descriptions/comments (`--description-file`, `--body-file`) and, where supported, Confluence page bodies.

## [1.0.0] - 2026-08-18

### Added

- `auth`, `search`, `sprint`, and `workitem` skills for managing Jira from the terminal via `acli`.
- `hooks/acli-auth-guard.sh`: PostToolUse hook that detects `acli` auth failures and surfaces guidance.
- `docs/reference.md` and `docs/commands.md`: CLI reference generated from `acli` (1.3.22-stable).
- `.claude-plugin/plugin.json` and `marketplace.json` for distribution as a Claude Code plugin/marketplace entry.

[unreleased]: https://github.com/moumine9/acli-skills/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/moumine9/acli-skills/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/moumine9/acli-skills/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/moumine9/acli-skills/releases/tag/v1.0.0
