{ pkgs }:
with pkgs; [
  # wayland projects
  pkg-config
  expat
  fontconfig
  freetype
  freetype.dev
  libGL
  pkg-config
  xorg.libX11
  xorg.libXcursor
  xorg.libXi
  xorg.libXrandr
  libxkbcommon
  vulkan-loader
  wayland
]
