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
        let
          typst = pkgs.typst.withPackages (
            ps:
            # cv.typ imports @preview/basic-resume by exact version; fail
            # loudly when nixpkgs moves on so the import string gets bumped
            # alongside instead of typst attempting a network download.
            assert ps.basic-resume.version == "0.2.9";
            [ ps.basic-resume ]
          );

          mkCv =
            targets:
            pkgs.stdenv.mkDerivation {
              name = "cv";
              src = pkgs.gitignoreSource ./.;

              nativeBuildInputs = [ typst ];

              env = {
                # Hermetic font resolution: only the fonts bundled with typst.
                TYPST_FLAGS = "--ignore-system-fonts";
                # datetime.today() honors this, dating the CV's footer with
                # the last commit instead of the epoch.
                SOURCE_DATE_EPOCH = toString (inputs.self.lastModified or 315532800);
              };

              buildFlags = targets;
              installTargets = map (target: "install-" + target) targets;
              makeFlags = [ "PREFIX=${placeholder "out"}" ];
            };
        in
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
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";
            flakeCheck = false; # Covered by git-hooks check
            programs = {
              nixfmt.enable = true;
              typstyle.enable = true;
            };
          };

          devShells.default = pkgs.mkShell {
            packages = [
              typst
              pkgs.tinymist
              pkgs.statix
            ]
            ++ (builtins.attrValues config.treefmt.build.programs);

            shellHook = config.pre-commit.installationScript;
          };

          packages = {
            pdf = mkCv [ "pdf" ];
            html = mkCv [ "html" ];
            default = mkCv [
              "pdf"
              "html"
            ];
          };
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
