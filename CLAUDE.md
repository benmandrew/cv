# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Typst CV for Ben Andrew. A single source file (`cv.typ`) compiles into three variants of the PDF depending on the `variant` input passed to `typst compile`.

## Commands

Enter the dev shell first (provides typst, make, and the Libertinus font — pinned via `flake.lock`):
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

Without Nix, install Typst directly (e.g. `brew install typst`), and make sure a font named `Libertinus Serif` is resolvable — either as a system font (e.g. `brew install --cask font-libertinus`), or via `TYPST_FONT_PATHS` pointing at a directory containing the Libertinus OTF files.

## Architecture

**Single source, three outputs** — `cv.typ` reads `sys.inputs.variant` at compile time (set via `typst compile --input variant=<name>`):

| `variant` | `for-website` | `no-links` | Effect |
|---|---|---|---|
| unset / `cv` | false | false | Standard CV |
| `website` | true | false | Adds "Last updated" timestamp, placed top-right, for benmandrew.com |
| `nolinks` | false | true | Renders link targets as plain text (no color/underline); also hides LinkedIn/GitHub from header |

The Makefile builds each variant straight into the repo root (no intermediate build directory needed — Typst has no aux files).

**Proportional page-fill** — all stretchable vertical whitespace (paragraph `leading`, list-item `spacing`, and the inter-entry/inter-section block gaps) is multiplied by a single scale factor `k`. The whole document lives in `cv-body(k)`; a trailing `context layout` block measures the body at `k=1` and `k=2` (height is affine in `k` since line count is fixed), solves for the `k` that fills the page, and re-emits the body at that `k`. `k` is clamped to `>= 1`, so overflow spills to a second page rather than compressing. This replaced an earlier `fr`-based approach — `fr` units can't drive `leading` or list `spacing`, only block-level `v()`. The base spacing values are the `base-*` constants near the top.

**Custom functions/values, defined inside `cv-body(k)`** (so they can close over the scale factor):
- `cventry(date, title, body)` — two-column entry (date right, title+bullets left); used for education, experience, teaching
- `section(title)` — bold heading with an underline rule; its leading gap scales with `k`
- `entryspacing` — `k * base-entry`; use `#v(entryspacing)` between sibling entries within a section
- `clink(url, body)` — link helper that respects `no-links` (defined at top level, not inside `cv-body`)

**Fonts** — the CV uses `Libertinus Serif` (the maintained fork of Linux Libertine). `flake.nix` exports `TYPST_FONT_PATHS` pointing at `pkgs.libertinus`'s `share/fonts/opentype` directory in the dev shell, so the OTFs resolve without installing anything system-wide. For reproducibility on any platform the repo build always targets the pinned Nix-provided font.

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
