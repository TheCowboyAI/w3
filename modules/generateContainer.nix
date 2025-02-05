{ system, module, nixpkgs, ... }:
nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    module
    { boot.isContainer = true; }
  ];
}
