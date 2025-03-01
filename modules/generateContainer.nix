{ system, nixpkgs, pkgs, modules, env, src, ... }:
nixpkgs.lib.nixosSystem
{
  inherit system pkgs;

  modules = modules ++ [
    {
      boot.isContainer = true;
      environment.sessionVariables = env;

    }
  ];
}
