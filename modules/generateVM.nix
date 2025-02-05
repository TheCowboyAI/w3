{ system, nixos-generators, nixpkgs, module, ... }:
nixos-generators.nixosGenerate {
  inherit system;
  modules = [{ nix.registry.nixpkgs.flake = nixpkgs; } module];
  format = "vm";
}
