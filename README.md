# CV

Enter a dev shell with all build dependencies (requires [Nix](https://nixos.org/download) with flakes enabled):

```sh
nix develop
```

Build:

```sh
make all
```

Produces:
- `cv.pdf`
- `website.pdf` with a timestamp for https://www.benmandrew.com
- `nolinks.pdf` that removes all hyperlinks from `cv.pdf`

Without Nix, install Typst directly (e.g. `brew install typst`), and make sure a font named `XCharter` (or `Charter`) is resolvable — either as a system font, or via `TYPST_FONT_PATHS` pointing at a directory containing the XCharter OTF files.
