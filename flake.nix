{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pkg = nixpkgs.lib.importTOML ./Cargo.toml;
        dependencies = import ./buildInputs.wayland.nix;
        buildRustPackage = import ./modules/buildPackage.nix;
      in
      rec {
        packages = {
          ${pkg.package.name} =
            buildRustPackage {
              inherit pkgs pkg;
              src = ./.;
              inherit (dependencies) buildInputs;
            };
        };

        defaultPackage = packages.${pkg.package.name};

        apps = rec {
          cim = flake-utils.lib.mkApp { drv = self.packages.${system}.cim; };
          default = cim;
        };
      }
    );
}






