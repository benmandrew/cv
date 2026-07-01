# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Typst CV for Ben Andrew. A single source file (`cv.typ`) compiles into three variants of the PDF depending on the `variant` input passed to `typst compile`.

## Commands

Enter the dev shell first (provides typst, make, and the XCharter font — pinned via `flake.lock`):
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

# Lint (compiles each variant to /dev/null, surfacing Typst warnings)
make lint

# Remove built PDFs from root
make clean
```

Without Nix, install Typst directly (e.g. `brew install typst`), and make sure a font named `XCharter` (or `Charter`) is resolvable — either as a system font, or via `TYPST_FONT_PATHS` pointing at a directory containing the XCharter OTF files.

## Architecture

**Single source, three outputs** — `cv.typ` reads `sys.inputs.variant` at compile time (set via `typst compile --input variant=<name>`):

| `variant` | `for-website` | `no-links` | Effect |
|---|---|---|---|
| unset / `cv` | false | false | Standard CV |
| `website` | true | false | Adds "Last updated" timestamp, placed top-right, for benmandrew.com |
| `nolinks` | false | true | Renders link targets as plain text (no color/underline); also hides LinkedIn/GitHub from header |

The Makefile builds each variant straight into the repo root (no intermediate build directory needed — Typst has no aux files).

**Custom functions defined in `cv.typ`**:
- `cventry(date, title, body)` — two-column entry (date right, title+bullets left); used for education, experience, teaching
- `section(title)` — bold heading with an underline rule, used for each section
- `clink(url, body)` — link helper that respects `no-links`
- `entryspacing` — `0.08cm`; use `#v(entryspacing)` between sibling entries within a section

**Fonts** — the CV uses `XCharter` (the OpenType, metric-compatible superset of Bitstream Charter). `flake.nix` pulls the font files out of `pkgs.texlive.xcharter`'s `run` package (not via `texlive.combine`, which doesn't merge font subdirectories reliably) and exports `TYPST_FONT_PATHS` in the dev shell. On macOS, plain "Charter" is also a built-in system font (used for local ad-hoc testing outside the dev shell), but the repo build always targets `XCharter` for reproducibility on any platform.

## Updating the "Last updated" date

The website variant timestamp is hardcoded in `cv.typ`:
```typst
#if for-website [
  #place(top + right, dy: -2cm)[
    #text(size: 8pt, fill: gray, style: "italic")[Last updated on Jun 27th, 2026]
  ]
]
```
Update this string when rebuilding for the website.
