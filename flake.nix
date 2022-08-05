{
  description = "lovesegfault's CV";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  };

  outputs = { self, gitignore, nixpkgs, utils }:
    utils.lib.eachSystem [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ gitignore.overlay ]; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "cv";
          src = pkgs.gitignoreSource ./.;

          nativeBuildInputs = with pkgs; [
            which
            python3Packages.pygments
            (texlive.combine {
              inherit (texlive)
                scheme-small
                latexmk
                latexindent
                lacheck
                chktex

                catchfile
                fontawesome
                fontaxes
                framed
                fvextra
                lipsum
                mfirstuc
                minted
                noto
                titlesec
                xstring
                ;
            })
          ];

          FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories = with pkgs; [ font-awesome_4 ]; };

          makeFlags = [ "PREFIX=${placeholder "out"}" ];
        };

        devShells.default = self.packages.${system}.default.overrideAttrs (oldAttrs: {
          buildInputs = with pkgs; (oldAttrs.buildInputs or [ ]) ++ [
            nix-linter
            nixpkgs-fmt
            pre-commit
            texlab
          ];
        });
      });
}
