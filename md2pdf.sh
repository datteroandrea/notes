#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:?Usage: $0 input.md [output.pdf]}"
OUTPUT="${2:-${INPUT%.md}.pdf}"

pandoc "$INPUT" \
    --from markdown \
    --pdf-engine=xelatex \
    --highlight-style=tango \
    -V geometry:margin=25mm \
    -V fontsize=11pt \
    -V colorlinks=true \
    -V linkcolor=blue \
    -o "$OUTPUT"

printf '✓ %s → %s\n' "$INPUT" "$OUTPUT"