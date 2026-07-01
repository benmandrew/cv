# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A LaTeX CV for Ben Andrew. A single source file (`cv.tex`) compiles into three variants of the PDF depending on the `\jobname` passed to `pdflatex`.

## Commands

Enter the dev shell first (provides pdflatex, chktex, lacheck, make — pinned via `flake.lock`):
```sh
nix develop
```

```sh
# Build all three PDFs
make all

# Build a specific PDF
make cv.pdf
make website.pdf
make nolinks.pdf

# Lint
make lint          # runs both linters
make lint-lacheck  # structural LaTeX checks
make lint-chktex   # style checks (suppresses warnings -n1 -n8 -n12)

# Remove built PDFs from root
make clean
```

Without Nix, install dependencies manually (Ubuntu/Debian):
```sh
sudo apt-get install -y texlive-latex-base texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra
```

## Architecture

**Single source, three outputs** — `cv.tex` sets two booleans (`for_website`, `no_links`) by inspecting `\jobname` at compile time:

| `\jobname` | `for_website` | `no_links` | Effect |
|---|---|---|---|
| `cv` | false | false | Standard CV |
| `website` | true | false | Adds "Last updated" timestamp for benmandrew.com |
| `nolinks` | false | true | Wraps body in `\begin{NoHyper}` to strip hyperlinks; also hides LinkedIn/GitHub from header |

Build artifacts go into `build/` then are copied to the repo root.

**`cv.sty`** — the style package defining all custom environments and commands:
- `cventry{date}{title}` — two-column entry (date right, title+bullets left); used for education, experience, teaching
- `onecolentry` — full-width block; used for publications and activities
- `highlights` — bullet list inside entries
- `header` — centred name + contact block at the top
- `\entryspacing` — defined in `cv.tex` as `0.20 cm`; use `\vspace{\entryspacing}` between sibling entries within a section

## Updating the "Last updated" date

The website variant timestamp is hardcoded in `cv.tex`:
```latex
\ifthenelse{\boolean{for_website}}{\updateinfo[Jun 27th, 2026]}{}
```
Update this string when rebuilding for the website.
