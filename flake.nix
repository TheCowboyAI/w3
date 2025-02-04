{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, nixos-generators, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkg = nixpkgs.lib.importTOML ./Cargo.toml;
      sharedEnv = import ./modules/sets/env.nix { inherit pkgs buildInputs; };
      buildInputs = import ./modules/lists/buildInputs.wayland.nix { inherit pkgs; };
      shellpackages = import ./modules/lists/packages.nix { inherit pkgs; };
      src = ./.;

      builder = import ./modules/buildPackage.nix;
      devshell = import ./modules/devshell.nix { inherit pkgs buildInputs; packages = shellpackages; env = sharedEnv; };
      configuration = import ./modules/configuration.nix { inherit pkgs; };
    in
    {
      packages.${system} = {
        ${pkg.package.name} =
          builder { inherit pkgs pkg buildInputs src; };

        default = self.packages.${system}.${pkg.package.name};

        cimVM = nixos-generators.nixosGenerate {
          inherit system;
          modules = [
            {
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            #self.packages.default
            configuration
          ];

          format = "vm";
        };
      };

      nixosConfigurations.container =
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            configuration
            {
              boot.isContainer = true;
            }
          ];
        };

      apps.${system} = {
        ${pkg.package.name} = flake-utils.lib.mkApp {
          drv = self.packages.${system}.${pkg.package.name};
        };
        default = self.apps.${system}.${pkg.package.name};
      };

      devShells.${system}.default = devshell;
    };
}






