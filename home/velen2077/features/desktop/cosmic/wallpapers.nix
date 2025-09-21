{
  config,
  lib,
  pkgs,
  inputs,
  cosmicLib,
  ...
}: {
  wayland.desktopManager.cosmic.wallpapers = [
    {
      filter_by_theme = true;
      filter_method = cosmicLib.cosmic.mkRON "enum" "Lanczos";
      output = "all";
      rotation_frequency = 300;
      sampling_method = cosmicLib.cosmic.mkRON "enum" "Alphanumeric";
      scaling_mode = cosmicLib.cosmic.mkRON "enum" "Zoom";
      source = cosmicLib.cosmic.mkRON "enum" {
        value = [
          "${config.theme.wallpaper}"
        ];
        variant = "Path";
      };
    }
  ];
}
