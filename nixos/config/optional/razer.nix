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
  environment.systemPackages = with pkgs; [
    razer-cli
    razergenie
  ];
}
