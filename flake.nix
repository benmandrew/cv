{
  description = "Dev shell for building the CV";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          tex = pkgs.texlive.combine {
            inherit (pkgs.texlive)
              scheme-basic
              geometry
              titlesec
              tools
              xcolor
              enumitem
              fontawesome5
              amsmath
              hyperref
              eso-pic
              etoolbox
              bookmark
              lastpage
              changepage
              paracol
              needspace
              iftex
              lm
              charter
              pdftex
              chktex
              lacheck
              ;
          };
        in {
          default = pkgs.mkShell {
            packages = [ tex pkgs.gnumake ];
          };
        });
    };
}
