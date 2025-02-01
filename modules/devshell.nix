{ pkgs, buildInputs, packages, ... }:
{
  devShells.default = pkgs.mkShell {
    name = "cim-devShell";

    buildInputs = buildInputs;

    # for the running shell
    packages = packages;
    LD_LIBRARY_PATH =
      builtins.foldl' (a: b: "${a}:${b}/lib") "${pkgs.vulkan-loader}/lib" buildInputs;
  };
}
