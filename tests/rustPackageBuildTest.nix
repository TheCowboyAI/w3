{ pkgs, system, self, pkg, ... }:

pkgs.runCommand "test-rust-package" { } ''
  ${self.packages.${system}.${pkg.package.name}} > /dev/null
''
