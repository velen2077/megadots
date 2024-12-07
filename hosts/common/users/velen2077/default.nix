{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.users.velen2077;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  options.modules.users.velen2077 = {
    enable = mkEnableOption "Enable the user velen2077.";
  };

  config = mkIf cfg.enable {
    users.mutableUsers = false;
    users.users.velen2077 = {
      isNormalUser = true;
      hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
      shell = pkgs.fish;
      extraGroups = ifTheyExist [
        "audio"
        "deluge"
        "docker"
        "git"
        "i2c"
        "libvirtd"
        "lxd"
        "minecraft"
        "mysql"
        "network"
        "plugdev"
        "podman"
        "video"
        "wheel"
        "wireshark"
      ];
      openssh.authorizedKeys.keys = [
        (builtins.readFile ./id_ed25519.pub)
      ];
      packages = [pkgs.home-manager];
    };

    #home-manager.users.gabriel = import ../../../../home/gabriel/${config.networking.hostName}.nix;

    security.pam.services = {
      #swaylock = {};
    };
  };
}
