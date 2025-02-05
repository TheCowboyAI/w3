{ pkgs, system, self, pkg }:
let
  buildInputs = import ../modules/lists/buildInputs.wayland.nix { inherit pkgs; };
  generateShellHook = attrs: builtins.concatStringsSep "\n" (map (key: "export ${key}='${attrs.${key}}'") (builtins.attrNames attrs));
  sharedEnv = import ../modules/sets/env.nix { inherit pkgs buildInputs; };
in
pkgs.runCommand "test-rust-package" { } ''
  ${generateShellHook sharedEnv}
   ${self.packages.${system}.${pkg.package.name}}/bin/${pkg.package.name} --version > /dev/null
''
