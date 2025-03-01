{ pkgs }:
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
  openssl.out
  openssl.dev
  openssl
  gnupg
  python3
  curl
]
