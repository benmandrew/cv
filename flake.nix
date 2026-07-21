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
        in {
          default = pkgs.mkShell {
            packages = [ pkgs.typst pkgs.gnumake ];
            # Libertinus ships the "Libertinus Serif" OTFs Typst needs.
            TYPST_FONT_PATHS = "${pkgs.libertinus}/share/fonts/opentype";
          };
        });
    };
}
