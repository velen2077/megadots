{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  name = "velen2077";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  cfg = config.megadots.host.users.${name};
in {
  options.megadots.host.users.${name} = {
    enable = mkEnableOption "Enable the named user.";
  };

  config = mkIf cfg.enable {
    #users.mutableUsers = false;
    users.users.${name} = {
      isNormalUser = true;
      #shell = pkgs.zsh;
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
      hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
      #icon = ../../../../assets/avatars/velen2077.png;
      #openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/gabriel/ssh.pub);
      #hashedPasswordFile = config.sops.secrets.gabriel-password.path;
      #packages = [pkgs.home-manager];
    };

    #environment.shells = with pkgs; [zsh];
    #programs.zsh.enable = true;

    #home-manager.users.velen2077 = import ../../../../home/velen2077/${config.networking.hostName}.nix;
  };
}
