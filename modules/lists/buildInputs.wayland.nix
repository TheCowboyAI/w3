{ pkgs }:
with pkgs;
[
  # Essential build dependencies
  pkg-config

  # Wayland and graphics support
  wayland
  wayland-protocols
  libGL
  vulkan-loader
  libxkbcommon # Required for keyboard input

  # Font rendering
  expat
  fontconfig
  freetype
  freetype.dev
  cairo
  pango
  harfbuzz

  # Fonts
  dejavu_fonts
  noto-fonts
  noto-fonts-emoji
  liberation_ttf

  # Security and encryption
  gnupg
  openssl.out
  openssl.dev

  # Rust toolchain
  rust-bin.stable.latest.default
]
