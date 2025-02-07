{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, nixos-generators, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
      };
      pkgName = pkg.package.name;
      src = ./.;
      pkg = nixpkgs.lib.importTOML ./Cargo.toml;
      sharedEnv = import ./modules/sets/env.nix { inherit pkgs buildInputs; };
      buildInputs = import ./modules/lists/buildInputs.wayland.nix { inherit pkgs; };
      shellpackages = import ./modules/lists/packages.nix { inherit pkgs; };
      configurationModule = import ./modules/configuration.nix;
      devshell = import ./modules/devshell.nix { inherit pkgs buildInputs; packages = shellpackages; env = sharedEnv; };
      buildPkg = import ./modules/buildPackage.nix { inherit pkgs pkg buildInputs src; env = sharedEnv; };
      generateContainer = import ./modules/generateContainer.nix { inherit system nixos-generators nixpkgs; module = configurationModule; };
      generateVM = import ./modules/generateContainer.nix { inherit system nixpkgs; module = configurationModule; };
      testBuild = import ./tests/test-build.nix { inherit pkgs system self pkg; };
    in
    {
      packages.${system} = {
        ${pkgName} = buildPkg;
        default = self.packages.${system}.${pkgName};
        cimVM = generateVM;
      };
      apps.${system} = {
        ${pkgName} = flake-utils.lib.mkApp {
          drv = self.packages.${system}.${pkgName};
        };
        default = self.apps.${system}.${pkgName};
      };
      devShells.${system}.default = devshell;
      nixosConfigurations.container = generateContainer;

      checks.${system} = {
        testBuild = testBuild;
      };
    };
}
