{ pkgs, buildInputs, ... }: {
  WAYLAND_DISPLAY = "wayland-1";
  XDG_RUNTIME_DIR = "/run/user/1000";
  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
  OPENSSL_DIR = "${pkgs.openssl}";
  OPENSSL_NO_VENDOR = "1";
  OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
  OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
}

