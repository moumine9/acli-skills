# Changelog

All notable changes to the `acli-skills` plugin are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.1.0] - 2026-08-18

### Added
- `atlassian-document-format` skill: converts Markdown into Atlassian Document Format (ADF) JSON for use with Jira descriptions/comments (`--description-file`, `--body-file`) and, where supported, Confluence page bodies.

## [1.0.0] - 2026-08-18

### Added
- `auth`, `search`, `sprint`, and `workitem` skills for managing Jira from the terminal via `acli`.
- `hooks/acli-auth-guard.sh`: PostToolUse hook that detects `acli` auth failures and surfaces guidance.
- `docs/reference.md` and `docs/commands.md`: CLI reference generated from `acli` (1.3.22-stable).
- `.claude-plugin/plugin.json` and `marketplace.json` for distribution as a Claude Code plugin/marketplace entry.
