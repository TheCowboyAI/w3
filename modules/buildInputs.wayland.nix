{ pkgs }:

{
  buildInputs = with pkgs; [
    # wayland projects
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
  ];


  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
}
