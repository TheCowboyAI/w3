{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, nixos-generators, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system nixos-generators;
        overlays = [ (import rust-overlay) ];
      };
      src = ./.;
      pkg = nixpkgs.lib.importTOML ./Cargo.toml;
      pkgName = pkg.package.name;
      env = import ./modules/sets/env.nix { inherit pkgs buildInputs; };
      buildInputs = import ./modules/lists/buildInputs.wayland.nix { inherit pkgs; };
      shellpackages = import ./modules/lists/packages.nix { inherit pkgs; };
      devshell = import ./modules/devshell.nix { inherit pkgs buildInputs env; packages = shellpackages; };
      testBuild = import ./tests/test-build.nix { inherit pkgs system self pkg; };
      users = import ./modules/users.nix { inherit pkgs; };
      configurationModule = import ./modules/configuration.nix { inherit pkgs buildInputs; packages = shellpackages; };
      buildPkg = import ./modules/buildPackage.nix { inherit pkgs pkg buildInputs src env; };
    in
    {
      packages.${system} = {
        ${pkgName} = buildPkg;
        default = self.packages.${system}.${pkgName};
      };

      apps.${system} = {
        ${pkgName} = flake-utils.lib.mkApp {
          drv = self.packages.${system}.${pkgName};
        };
        default = self.apps.${system}.${pkgName};
      };
      devShells.${system}.default = devshell;

      nixosConfigurations."${pkgName}c" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          configurationModule
          users
          {
            boot.isContainer = true;
            environment.systemPackages = [
              self.packages.${system}.${pkgName}
            ];
            nixpkgs.overlays = [ (import rust-overlay) ];
          }
        ];
      };
    };
}
