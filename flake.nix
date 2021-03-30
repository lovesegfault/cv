{
  description = "lovesegfault's CV";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
  };

  outputs = { self, flake-utils, gitignore, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        gitignoreSource = (import gitignore { inherit (pkgs) lib; }).gitignoreSource;
      in
      {
        defaultPackage = with pkgs; stdenv.mkDerivation {
          name = "cv";
          src = gitignoreSource ./.;

          buildInputs = [
            (texlive.combine {
              inherit (texlive)
                scheme-small
                latexmk

                isodate
                substr
                textpos
                titlesec
                ;
            })
          ];

          makeFlags = [ "PREFIX=${placeholder "out"}" ];

          buildPhase = "make";
        };

        devShell = with pkgs; mkShell {
          name = "cv";
          buildInputs = (self.defaultPackage.${system}.buildInputs or [ ]) ++ [
            nixpkgs-fmt
            nix-linter
            texlab
          ];
        };
      });
}
