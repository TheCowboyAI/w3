{ pkgs, pkg, buildInputs, src, env }:
let
  generateShellHook = attrs: builtins.concatStringsSep "\n" (map (key: "export ${key}='${attrs.${key}}'") (builtins.attrNames attrs));
in
pkgs.rustPlatform.buildRustPackage {

  buildType = "debug";

  pname = pkg.package.name;
  version = pkg.package.version;
  src = src;
  cargoLock.lockFile = "${src}/Cargo.lock";
  buildInputs = buildInputs;

  cargoHash = "";

  buildPhase = ''
    ${generateShellHook env}
    cargo build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp "target/debug/${pkg.package.name}" $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "Composable Information Machine";
    license = licenses.mit;
    maintainers = with maintainers; [ thecowboyai ];
  };
}
