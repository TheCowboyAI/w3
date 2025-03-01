{ pkgs, packages, buildInputs, ... }:
let
  shellInit = ''
    touch .zshrc
    export NIX_PATH=nixpkgs=${pkgs.path}
    export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
  '';
in
{
  # Configure Nix with flakes enabled
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  environment.systemPackages = buildInputs ++ packages;

  systemd.tmpfiles.rules = [
    "d /run/user/1000/wayland-1 0777 cim users"
    "d /src 0777 cim users"
  ];

  # Configure shell environment for Nix
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  programs.zsh = {
    inherit shellInit;
    enable = true;

  };
  programs.bash = {
    inherit shellInit;
  };

  # Minimal networking configuration
  networking.firewall.enable = false;

  # Set locale for the container
  i18n.defaultLocale = "en_US.UTF-8";

  # Set system state version (matches your NixOS version)
  system.stateVersion = "25.05";
}
