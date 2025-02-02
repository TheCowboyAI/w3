{ pkgs, buildInputs, ... }: {
  WAYLAND_DISPLAY = "wayland-1";
  XDG_RUNTIME_DIR = "/run/user/1000";
  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
}
