{
  config,
  cosmicLib,
  pkgs,
  ...
}: let
  inherit (cosmicLib.cosmic) importRON mkRON;
in {
  wayland.desktopManager.cosmic.appearance = {
    theme = {
      dark = importRON ./rosepine.ron;
      mode = "dark";
    };

    toolkit = {
      apply_theme_global = true;
    };
  };
}
