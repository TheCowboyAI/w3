{ pkgs, ... }: {

  users.users.root = {
    hashedPassword = "$6$MqgpRGjqwfm6T7yv$Xt1n14aVnAHL9uaJEXBbYyPE7VF2tBo8VON7ODpZyPnSUFg0RXebcn17wJu/aqImtJzBVLqcvIcHmbwIbmZyR1";
    shell = pkgs.zsh;
  };

  users.users.cim = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "video" "audio" "messagebus" "dbus" "pipewire" ];
    hashedPassword = "$6$MqgpRGjqwfm6T7yv$Xt1n14aVnAHL9uaJEXBbYyPE7VF2tBo8VON7ODpZyPnSUFg0RXebcn17wJu/aqImtJzBVLqcvIcHmbwIbmZyR1";
    shell = pkgs.zsh;
  };
}
