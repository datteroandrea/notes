#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:?Usage: $0 input.md [output.pdf]}"
OUTPUT="${2:-${INPUT%.md}.pdf}"

# LaTeX preamble additions:
# - enumitem: LaTeX allows only 4 nested itemize levels ("Too deeply nested");
#   raise the limit to 9 and cycle the bullet symbols.
# - newunicodechar: Latin Modern has no ≈ ≤ ≥ glyphs, so xelatex would drop
#   them silently; render them with the math symbols instead.
HEADER="$(mktemp --suffix=.tex)"
trap 'rm -f "$HEADER"' EXIT
cat > "$HEADER" <<'EOF'
\usepackage{enumitem}
\setlistdepth{9}
\renewlist{itemize}{itemize}{9}
\setlist[itemize,1]{label=\textbullet}
\setlist[itemize,2]{label=\textendash}
\setlist[itemize,3]{label=\textasteriskcentered}
\setlist[itemize,4]{label=\textperiodcentered}
\setlist[itemize,5]{label=\textbullet}
\setlist[itemize,6]{label=\textendash}
\setlist[itemize,7]{label=\textasteriskcentered}
\setlist[itemize,8]{label=\textperiodcentered}
\setlist[itemize,9]{label=\textbullet}
\renewlist{enumerate}{enumerate}{9}
\setlist[enumerate]{label=\arabic*.}
\usepackage{newunicodechar}
\newunicodechar{≈}{\ensuremath{\approx}}
\newunicodechar{≤}{\ensuremath{\leq}}
\newunicodechar{≥}{\ensuremath{\geq}}
EOF

pandoc "$INPUT" \
    --from markdown \
    --pdf-engine=xelatex \
    --highlight-style=tango \
    -V geometry:margin=25mm \
    -V fontsize=11pt \
    -V colorlinks=true \
    -V linkcolor=blue \
    -H "$HEADER" \
    -o "$OUTPUT"

printf '✓ %s → %s\n' "$INPUT" "$OUTPUT"
