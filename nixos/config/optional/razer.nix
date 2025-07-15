# This file (and the global directory) holds config that i use on all hosts
{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  hardware.openrazer = {
    enable = true;
  };
  services.ratbagd.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
    razer-cli
    razergenie
  ];
}
