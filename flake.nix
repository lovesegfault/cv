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
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ gitignore.overlay ]; };
      in
      {
        defaultPackage = with pkgs; stdenv.mkDerivation {
          name = "cv";
          src = gitignoreSource ./.;

          nativeBuildInputs = [
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

          FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ font-awesome_4 ]; };

          makeFlags = [ "PREFIX=${placeholder "out"}" ];
        };

        devShell = self.defaultPackage.${system}.overrideAttrs (oldAttrs: {
          buildInputs = with pkgs; (oldAttrs.buildInputs or [ ]) ++ [
            nix-linter
            nixpkgs-fmt
            pre-commit
            texlab
          ];
        });
      });
}
