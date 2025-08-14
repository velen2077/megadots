{
  inputs,
  config,
  lib,
  settings,
  pkgs,
  ...
}: {
  imports = [
    ./hypridle/hypridle.nix
    ./hyprlock/hyprlock.nix
    ./hyprpaper/hyprpaper.nix
    ./mako/mako.nix
    ./rofi/rofi.nix
    ./scripts/scripts.nix
    ./waybar/waybar.nix
    ./env.nix
    ./binds.nix
    ./scripts.nix
    ./rules.nix
    ./settings.nix
    ./plugins.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
  };
}
