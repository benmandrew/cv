{
  description = "Dev shell for building the CV";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          # XCharter provides the OpenType "Charter"-family fonts Typst needs;
          # pulled in via texlive rather than nixpkgs' font sets, which don't
          # package it directly.
          xcharterRun = pkgs.lib.findFirst (p: p.tlType == "run") null pkgs.texlive.xcharter.pkgs;
        in {
          default = pkgs.mkShell {
            packages = [ pkgs.typst pkgs.gnumake ];
            TYPST_FONT_PATHS = "${xcharterRun}/fonts/opentype/public/xcharter";
          };
        });
    };
}
