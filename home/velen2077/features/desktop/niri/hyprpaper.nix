{
  config,
  pkgs,
  lib,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = ["${../../../../../assets/wallpaper/gruvbox-battlefield.png}"];

      wallpaper = [
        ",${../../../../../assets/wallpaper/gruvbox-battlefield.png}"
      ];
    };
  };
}
