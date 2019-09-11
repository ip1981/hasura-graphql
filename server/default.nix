{ boot ? import <nixpkgs> {} }:

let

  filtFn = root: path: type:
    let
      name = baseNameOf path;
      hidden = builtins.match "\\..+" name != null;
      nix = builtins.match ".*\\.nix" name != null;
      r = !hidden && !nix ;
    in builtins.trace (path + ": " + (if r then "yes" else "no")) r;

  fltsrc = builtins.filterSource (filtFn (builtins.toPath ./. + "/"));

  nixpkgs = boot.pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "259202cb8021b6cfeb6ddf49239daf1ea5aeb724";
    sha256 = "0sgfqqhjx0jb68lis6yazb2rdxq0563blgh0lyn4kf2f4ajh2z4b";
  };

  config = {
    allowUnfree = true; # for local packages
    allowBroken = true; # some nixpkgs' nonsense
  };

  inherit (import nixpkgs { inherit config; }) pkgs;
  inherit (pkgs) lib;

  nixHaskellPackages =
    let
      isnix = n: _: null != builtins.match ".*\\.nix" n && n != "default.nix";
      files = lib.filterAttrs isnix (builtins.readDir ./.);
    in lib.mapAttrs' (n: _:
          { name = lib.removeSuffix ".nix" n;
            value = ./. + "/${n}";
          }) files;

  localHaskellPackages =
    let
      islocal = n: t: !lib.hasPrefix "." n && t == "directory";
      files = lib.filterAttrs islocal (builtins.readDir ./.);
    in lib.mapAttrs (n: _: fltsrc (./. + "/${n}")) files;

  haskellPackages =
    let

      hlib = pkgs.haskell.lib;

      set0 = pkgs.haskell.packages.ghc865;

      set1 = set0.extend (
        self: super:
          lib.mapAttrs (_: f: super.callPackage f {}) nixHaskellPackages
      );

      set2 = set1.extend (
        self: super:
          lib.mapAttrs (n: d: super.callCabal2nix n d {}) localHaskellPackages
      );

      set3 = set2.extend (
        self: super: {
          mkDerivation = drv: super.mkDerivation (drv // {
            buildTools = (drv.buildTools or []) ++ [ self.ghc.llvmPackages.llvm ];

            # XXX a lot of troubles are cause by tests which require fancy packages of features.
            # XXX Enable tests for critical packages when unsure.
            doCheck = false;

            enableExecutableProfiling = false;
            enableLibraryProfiling = false;

            configureFlags = (drv.configureFlags or []) ++ [
              "--ghc-option=-O2"
              "--ghc-option=-Wall"
              "--ghc-option=-optl-fuse-ld=gold" "--ld-option=-fuse-ld=gold" "--with-ld=ld.gold"
              "--ghc-option=-optl-pthread"

              # "--ghc-option=-fllvm" "--ghc-option=-optlo-O2"

              "--ghc-option=+RTS"
              "--ghc-option=-A64m"
              "--ghc-option=-n2m"
              "--ghc-option=-RTS"
            ];
          });

          primitive = self.primitive_0_7_0_0;
          primitive-extras = self.primitive-extras_0_8;

        });

      set4 = set3.extend (
        self: super:
          lib.mapAttrs (n: _:
              hlib.overrideCabal super.${n} (drv:
                {
                  doCheck = true;
                  configureFlags = (drv.configureFlags or []) ++ [
                   # TODO: not ready  "--ghc-option=-Werror"
                  ];
                })
            ) localHaskellPackages);

      set = set4.extend (
        self: super: {
          graphql-engine = hlib.justStaticExecutables super.graphql-engine;
        }
      );

    in set;

in haskellPackages
