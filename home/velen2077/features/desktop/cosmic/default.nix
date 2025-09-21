{
  config,
  lib,
  pkgs,
  inputs,
  cosmicLib,
  ...
}: {
  imports = [
    inputs.cosmic-manager.homeManagerModules.cosmic-manager

    ./appearance.nix
    ./applets.nix
    ./compositor.nix
    ./panels.nix
    ./shortcuts.nix
    ./wallpapers.nix
  ];

  wayland.desktopManager.cosmic = {
    enable = true;
    #resetFiles = true;
  };
}
