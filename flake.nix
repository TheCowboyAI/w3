{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        #sets
        pkgs = import nixpkgs { inherit system; };
        pkg = nixpkgs.lib.importTOML ./Cargo.toml;
        sharedEnv = import ./modules/env.nix { inherit pkgs buildInputs; };
        #lists
        buildInputs = import ./modules/buildInputs.wayland.nix { inherit pkgs; };
        shellpackages = import ./modules/packages.nix { inherit pkgs; };
        #functions
        builder = import ./modules/buildPackage.nix;
        devshell = import ./modules/devshell.nix { inherit pkgs buildInputs; packages = shellpackages; env = sharedEnv; };
        src = ./.;
      in
      rec {
        packages = {
          ${pkg.package.name} =
            builder {
              inherit pkgs pkg buildInputs src;
            };
        };

        defaultPackage = packages.${pkg.package.name};

        apps = rec {
          cim = flake-utils.lib.mkApp { drv = self.packages.${system}.cim; };
          default = cim;
          drv = self.packages.${system}.${pkg.package.name};
          env = sharedEnv;
        };

        devShells.default = devshell;

        templates = {
          cim = {
            path = ./.;
            description = "Template for a cim";
          };
        };
      }
    );
}






