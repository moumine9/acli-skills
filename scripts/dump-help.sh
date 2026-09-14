#!/usr/bin/env bash
# Recursively dump `acli ... --help` for every subcommand into one file.
# The committed dump (docs/acli-help.txt) is the baseline: re-run after upgrading
# acli and `git diff` it to see exactly which commands and flags changed.
#
# Usage: scripts/dump-help.sh [acli-binary] [outfile]
#   defaults: acli  docs/acli-help.txt
#
# Skipped: `help`, `completion` (generated), `guard` (separate plugin, usually not
# installed), and `rovodev` (separately versioned plugin; its help triggers a download).
# Each call takes a few seconds, so a full run takes ~10 minutes.
set -euo pipefail

bin="${1:-acli}"
out="${2:-docs/acli-help.txt}"

version=$("$bin" --version 2>&1 | head -n 1)
printf '# %s\n\n' "$version" > "$out"

walk() {
  local help subs s
  help=$("$bin" "$@" --help 2>&1 | grep -v -e "outdated version" -e "Follow this link" || true)
  printf '===== acli %s\n%s\n\n' "$*" "$help" >> "$out"
  subs=$(printf '%s\n' "$help" | awk '/^(Available|Additional) Commands:?$/{f=1;next} f&&/^[^ ]/{f=0} f&&NF{print $1}')
  for s in $subs; do
    case "$s" in help|completion|rovodev|guard) continue;; esac
    walk "$@" "$s"
  done
}
walk

echo "Wrote $(grep -c '^=====' "$out") help pages from '$version' to $out"
