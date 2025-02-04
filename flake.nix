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

      # Load tests from separate files
      rustPackageBuildTest = import ./tests/rustPackageBuildTest.nix { inherit pkgs system self pkg; };
      containerTest = import ./tests/containerTest.nix { inherit pkgs system self; };
      vmTest = import ./tests/vmTest.nix { inherit pkgs system self; };
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

      # Add checks for testing
      checks.${system} = {
        rustPackageBuildTest = rustPackageBuildTest;
        containerTest = containerTest;
        vmTest = vmTest;
      };
    };
}
