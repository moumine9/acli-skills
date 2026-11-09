# Project instructions

Read and follow [AGENTS.md](AGENTS.md) for repository navigation, documentation
refreshes, validation, and GitHub submission and release conventions.

For an ACLI upgrade, use the project-local `/update-acli-docs` skill defined in
[.claude/skills/update-acli-docs/SKILL.md](.claude/skills/update-acli-docs/SKILL.md).
It compares the installed CLI help tree with `docs/acli-help.txt`; the public
Atlassian changelog is supplementary because it may not cover recent releases.

The distributable plugin skills live under `skills/`. The maintainer skill under
`.claude/skills/` is local to this repository and is not a published plugin skill.
