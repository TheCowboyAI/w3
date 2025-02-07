{ pkgs }:
let
  rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ../../rust-toolchain.toml;
in
with pkgs; [
  # wayland projects
  pkg-config
  expat
  fontconfig
  freetype
  freetype.dev
  libGL
  xorg.libX11
  xorg.libXcursor
  xorg.libXi
  xorg.libXrandr
  libxkbcommon
  vulkan-loader
  wayland

  # others cim needs
  qemu
  rustToolchain
  openssl.out
  openssl.dev
  openssl
  gnupg
  python3
  curl
]
