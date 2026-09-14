---
name: update-acli-docs
description: Maintainer workflow for this repo — upgrade the local Atlassian CLI (acli), detect which commands and flags changed, and update docs/, skills/, README, CHANGELOG, and the plugin version to match. Use when acli reports "You're using an outdated version", or the user asks to update acli or refresh the acli documentation.
disable-model-invocation: true
argument-hint: "[acli-binary-path]"
---

## Task

Bring this plugin's documentation and skills in line with the latest `acli` release.

Atlassian's changelog (https://developer.atlassian.com/cloud/acli/changelog/, and its RSS feed) lags far behind releases. As of 1.3.36 it stops at 1.3.15. **Don't rely on it.** The source of truth is the diff of `acli --help` output against the committed baseline in `docs/acli-help.txt`.

## Steps

### 1. Check the installed version

```bash
acli --version
```

The output shows the latest version when an update is available. There may be more than one copy on PATH, so list them all:

- Windows: `Get-Command acli -All | % { $_.Source; & $_.Source --version }`
- macOS/Linux: `which -a acli`

Compare with the version on the first line of `docs/acli-help.txt`. If they match and no update is pending, stop: the docs are current.

### 2. Upgrade acli

- **macOS:** `brew upgrade atlassian/tap/acli`
- **Windows:** download to a scratch dir first, then check it runs:
  ```powershell
  Invoke-WebRequest -Uri https://acli.atlassian.com/windows/latest/acli_windows_amd64/acli.exe -OutFile <scratch>\acli.exe   # arm64: acli_windows_arm64
  <scratch>\acli.exe --version
  ```
  The install dirs are under `Program Files`, so replacing the exe needs admin rights and the user must approve a UAC prompt. Ask the user to run the copy themselves (`! Start-Process pwsh -Verb RunAs ...`). Update **every** copy found on PATH in step 1, or the stale one first on PATH will shadow the new one.
- **Linux:** re-download the binary per https://developer.atlassian.com/cloud/acli/guides/install-acli/

If the upgrade can't be installed yet, you can still run the next steps against the downloaded binary by passing its path to the script.

### 3. Dump the help tree and diff it

A full run takes about 10 minutes, so run it in the background. Pass the binary path given in the arguments (`$ARGUMENTS`), or `acli` if none was given:

```bash
bash scripts/dump-help.sh <acli-binary> docs/acli-help.txt
git diff --stat docs/acli-help.txt
git diff docs/acli-help.txt
```

If the only changed line is the `# acli version` header, the CLI surface didn't change. Skip to step 6.

The script skips `rovodev` (separately versioned plugin, and its help triggers a download) and `guard` (not installed by default). To check rovodev's top-level subcommands, run `acli rovodev --help` once by hand. **Never** run `rovodev run`/`serve`/etc. to inspect them.

### 4. Apply each change to the docs

For every added, removed, renamed, or deprecated command or flag in the diff:

- `docs/commands.md`: one table row per command; mark deprecated ones `(deprecated, use \`x\`)`.
- `docs/reference.md`: subcommand tables and flag blocks.
- `skills/*/SKILL.md`: grep for the command (`rg "acli jira workitem edit" skills/`) and fix the examples and flag lists.
- `skills/atlassian-document-format/SKILL.md` says Confluence pages can't be created/updated from ADF. If `acli confluence page create|update` appears, rewrite that paragraph.

Check that every leaf command in the dump is documented. The command below should print nothing:

```bash
comm -13 \
  <(grep -o '^| `acli [^`]*' docs/commands.md | sed 's/^| `//; s/ *$//' | sort -u) \
  <(awk '/^===== /{if(h!=""&&!s)print h;h=substr($0,7);s=0;next} /^(Available|Additional) Commands:?$/{s=1} END{if(!s)print h}' docs/acli-help.txt | sort -u)
```

### 5. Update the command count

The README's "**N commands**" is the number of table rows in `docs/commands.md`, including rovodev and deprecated aliases:

```bash
grep -c '^| `acli' docs/commands.md
```

### 6. Record the release

- `CHANGELOG.md` follows [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/):
  - Move items from `## [Unreleased]` into a new `## [X.Y.Z] - YYYY-MM-DD` section, and leave an empty `## [Unreleased]` above it.
  - Group changes under `### Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`. Leave out empty groups.
  - Name the acli version the docs now match. If the CLI didn't change, say so.
  - Update the link references at the bottom: `[unreleased]` compares `vX.Y.Z...HEAD`, and add `[X.Y.Z]: .../compare/vPREV...vX.Y.Z`.
- Bump `version` in `.claude-plugin/plugin.json` (`marketplace.json` has no version field). Use a patch bump for doc-only changes and a minor bump if skills gained new capabilities.
- Commit `docs/acli-help.txt` with the doc changes. It becomes the baseline for the next run.
