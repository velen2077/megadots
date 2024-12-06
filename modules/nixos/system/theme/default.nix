{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.system.theme;
in {
  options.megadots.nixos.system.theme = with types; {
    enable = mkEnableOption "Whether to enable the system theme.";

    wallpaper = mkOption {
      type = path;
      default = null;
      example = "../../../../assets/wallpapers/monokai.jpeg";
      description = "
        The path to a wallpaper, if Stylix should use
        a wallpaper to theme the system.
      ";
    };

    darkmode = mkOption {
      type = bool;
      default = true;
      example = true;
      description = "
        Use dark mode for colour generation. If set to true,
        dark mode will be used throughout Stylix theming. If
        set to false, Stylix will default to light mode.
      ";
    };
  };

  config = mkIf cfg.enable {
    # Apply Stylix styling to this system for colour scheming
    # and wallpaper. This applies globally to the system.
    stylix.enable = false;
    stylix.autoEnable = true;
    stylix.image = mkIf (cfg.wallpaper != null) cfg.wallpaper;
    stylix.imageScalingMode = "fill";
    stylix.polarity = mkIf (!cfg.darkmode) "dark";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    # Set the system cursor type. I like Bibata Modern Classic.
    stylix.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
