# This file (and the global directory) holds config that i use on all hosts
{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.uinput.enable = true;

  # Allow users to mount removable drives.
  services.udisks2.enable = true;
}
