{ pkgs, buildInputs, packages, ... }:
pkgs.mkShell {
  name = "cim-devShell";

  buildInputs = buildInputs;

  packages = packages;

}

