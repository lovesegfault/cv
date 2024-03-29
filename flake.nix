{
  description = "lovesegfault's CV";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        gitignore.follows = "gitignore";
      };
    };
  };

  outputs = { self, flake-utils, gitignore, nixpkgs, pre-commit }:
    flake-utils.lib.eachSystem [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ gitignore.overlay ]; };
        inherit (pkgs) lib;
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
          nativeBuildInputs = with pkgs; (oldAttrs.nativeBuildInputs or [ ]) ++ [
            actionlint
            ltex-ls
            nixpkgs-fmt
            statix
            nil
            texlab
          ];

          inherit (self.checks.${system}.pre-commit) shellHook;
        });

        checks.pre-commit = pre-commit.lib.${system}.run {
          src = pkgs.gitignoreSource ./.;
          hooks = {
            actionlint.enable = true;
            chktex.enable = true;
            latexindent.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        };
      });
}
