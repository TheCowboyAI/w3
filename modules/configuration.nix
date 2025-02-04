{ pkgs, ... }:
let
  generateShellHook = attrs: builtins.concatStringsSep "\n" (map (key: "export ${key}='${attrs.${key}}'") (builtins.attrNames attrs));
  buildInputs = import ./lists/buildInputs.wayland.nix { inherit pkgs; };
  packages = import ./lists/packages.nix { inherit pkgs; };
  env = import ./sets/env.nix { inherit pkgs buildInputs; };
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

  # Configure shell environment for Nix
  programs.bash = {
    completion.enable = true;
    shellInit = ''
      export NIX_PATH=nixpkgs=${pkgs.path}
      export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      ${generateShellHook env}
    '';
  };

  fileSystems."/src".label = "source";

  # Minimal networking configuration
  networking.firewall.enable = false;

  # Set locale for the container
  i18n.defaultLocale = "en_US.UTF-8";

  # Set system state version (matches your NixOS version)
  system.stateVersion = "25.05";
}
