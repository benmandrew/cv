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

Without Nix, install dependencies manually (Ubuntu/Debian):

```sh
sudo apt-get install -y texlive-latex-base texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra
```
