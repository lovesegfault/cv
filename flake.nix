{
  inputs = {
    self.lfs = true;
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        gitignore.follows = "gitignore";
      };
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.
          _module.args.pkgs = import inputs.nixpkgs {
            localSystem = system;
            overlays = [ inputs.gitignore.overlay ];
          };
          pre-commit = {
            check.enable = true;
            settings.hooks = {
              actionlint.enable = true;
              nil.enable = true;
              statix.enable = true;
              treefmt.enable = true;
              chktex.enable = true;
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";
            flakeCheck = false; # Covered by git-hooks check
            programs = {
              nixfmt.enable = true;
              latexindent.enable = true;
            };
            settings.formatter.latexindent.options = [ "-l" ];
          };

          devShells.default = self'.packages.default.overrideAttrs (old: {
            nativeBuildInputs =
              (old.nativeBuildInputs or [ ])
              ++ (with pkgs; [ statix ])
              ++ (builtins.attrValues config.treefmt.build.programs);

            shellHook = config.pre-commit.installationScript;
          });

          packages.default = pkgs.stdenv.mkDerivation {
            name = "cv";
            src = pkgs.gitignoreSource ./.;

            nativeBuildInputs = with pkgs; [
              (texlive.combine {
                inherit (texlive)
                  scheme-basic

                  latexmk
                  xetex

                  fontawesome
                  fontspec
                  lineno
                  lipsum
                  mfirstuc
                  minted
                  noto
                  pgf
                  titlesec
                  upquote
                  xcolor
                  xkeyval
                  ;
              })
              (python3.withPackages (ps: with ps; [ pygments ]))
            ];

            preBuild = ''
              export XDG_CACHE_HOME="$(mktemp -d)"
              export XDG_CONFIG_HOME="$(mktemp -d)"
              mkdir -p "$XDG_CACHE_HOME/texmf-var"
              export TEXMFHOME="$XDG_CACHE_HOME" TEXMFVAR="$XDG_CACHE_HOME/texmf-var"
            '';

            makeFlags = [ "PREFIX=${placeholder "out"}" ];
          };
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
