{
  inputs = {
    self.lfs = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        # Only used by upstream's default.nix, which we don't consume.
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
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
          lib,
          pkgs,
          ...
        }:
        let
          # cv.typ imports @preview/basic-resume by exact version, so pin the
          # same one here. Bump both together.
          typst = pkgs.typst.withPackages (ps: [ ps.basic-resume_0_2_9 ]);

          typstEnv = {
            # Hermetic font resolution: only the fonts bundled with typst.
            TYPST_FLAGS = "--ignore-system-fonts";
          };

          mkCv =
            targets:
            pkgs.stdenvNoCC.mkDerivation {
              name = "cv";
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./Makefile
                  ./content.typ
                  ./cv-html.typ
                  ./cv.typ
                  ./images
                ];
              };

              nativeBuildInputs = [
                pkgs.gnumake
                typst
              ];

              env = typstEnv // {
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

          devShells.default = pkgs.mkShellNoCC {
            env = typstEnv // {
              # The typst wrapper sets this for itself, but tinymist needs it
              # too in order to resolve the template.
              TYPST_PACKAGE_CACHE_PATH = "${typst}/lib/typst/packages";
            };

            packages = [
              pkgs.gnumake
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

          # `nix flake check` only evaluates packages, so build the CV here to
          # catch broken layouts and page overflows.
          checks.cv = config.packages.default;
        };
    };
}
