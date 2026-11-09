# Repository guidance

This repository publishes the `acli-skills` Claude Code plugin at
`moumine9/acli-skills` on GitHub. The default branch is `master`.

## Search and read

Use `glab orbit grep` for repository searches and `glab orbit context` to read
source. Batch related files and searches when possible.

## Refresh ACLI documentation

Follow [.claude/skills/update-acli-docs/SKILL.md](.claude/skills/update-acli-docs/SKILL.md)
when updating the CLI documentation or skills after an ACLI upgrade.

- Check every ACLI executable on PATH and use an explicit binary path when
  multiple versions are installed.
- Regenerate `docs/acli-help.txt` with `scripts/dump-help.sh`, wait for it to
  finish, and compare it with the committed baseline. The public Atlassian
  changelog may lag releases; use it as supplementary evidence. Help differences
  establish command and flag changes, not internal bug fixes or behavior changes.
- Update `docs/commands.md`, `docs/reference.md`, and affected workflow skills.
  Keep the README command count equal to the command table row count, including
  deprecated aliases and separately documented plugin commands.
- Rovo Dev and Guard are separately versioned plugins excluded from the dump.
  State whether they were checked. Do not start an agent or server to inspect help.
- Verify every leaf command in the completed dump is documented, check the
  plugin manifest parses as JSON, and run `git diff --check`.

The current baseline is ACLI **1.3.40-stable**, with **116 help pages** and
**105 documented command rows**. The only help change from 1.3.36 was removal of
`acli completion`; old shell profile invocations now fail. Plugin **v1.1.3**
records this refresh. Recalculate these values on the next upgrade.

## Commit, PR, and release

- Stage only files relevant to the task; preserve unrelated local artifacts.
- When asked to submit changes, create a branch, commit, push to GitHub, and open
  a PR against `master` with a concise description and validation results.
- For a versioned update, keep `.claude-plugin/plugin.json` and `CHANGELOG.md`
  aligned. Use a patch bump for documentation changes and a minor bump for new
  skill capabilities. The marketplace manifest has no version field.
- When asked to merge and release, check PR mergeability and available checks,
  merge the reviewed head, and publish a GitHub release tagged `vX.Y.Z` targeting
  the confirmed merge commit. Verify the published release and tag target, then
  sync local `master` with a fast-forward pull.
