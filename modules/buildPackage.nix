{ pkgs, pkg, src, buildInputs }:
pkgs.rustPlatform.buildRustPackage {
  pname = pkg.package.name;
  version = pkg.package.version;
  src = src;
  cargoLock.lockFile = "${src}/Cargo.lock";
  buildInputs = buildInputs;
}
