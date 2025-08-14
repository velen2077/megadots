# This file (and the global directory) holds config that i use on all hosts
{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Enable adb and dconf for the host.
  programs = {
    adb.enable = true;
    dconf.enable = true;
    #seahorse.enable = true;
  };
}
