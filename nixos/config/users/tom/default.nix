{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.tom = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "mysql"
      "network"
      "plugdev"
      "podman"
      "openrazer"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./keys/id_ed25519.pub)
    ];
    packages = [pkgs.home-manager];
  };

  home-manager.users.tom = import ../../../../home/tom/${config.networking.hostName}.nix;
}
