{
  config,
  lib,
  pkgs,
  inputs,
  cosmicLib,
  ...
}: {
  wayland.desktopManager.cosmic.shortcuts = [
    {
      action = cosmicLib.cosmic.mkRON "enum" "Minimize";
      key = "Super+Shift+M";
    }
  ];
}
