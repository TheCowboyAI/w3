{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
      };
      pkgName = pkg.package.name;
      src = ./.;
      pkg = nixpkgs.lib.importTOML ./Cargo.toml;
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

      nixosConfigurations = {
        "${pkgName}c" = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [ users ] ++ [
            ({ config, pkgs, ... }: {

              containers."${pkgName}c" = {
                ephemeral = true;

                config = configurationModule;

                bindMounts."/run/user/1000/wayland-1" = {
                  hostPath = "/run/user/1000/wayland-1";
                  isReadOnly = false;
                };

                allowedDevices = [
                  {
                    node = "/dev/dri";
                    modifier = "rwm";
                  }
                ];
              };

              environment.systemPackages = [
                self.packages.${system}.${pkgName}
              ];
              nixpkgs.overlays = [ (import rust-overlay) ];
            })
          ];
        };
      };

      # checks.${system} = {
      #   testBuild = testBuild;
      # };
    };
}
