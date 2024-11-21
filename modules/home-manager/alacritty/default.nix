{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.alacritty;
in {
  options.megadots.alacritty = {
    enable = mkEnableOption "Enable and customise the alacritty terminal emulator.";
  };

  config = mkIf cfg.enable {
    programs.alacritty.enable = true;
    programs.alacritty.settings = {
      general = {
        working_directory = config.home.homeDirectory;
      };
    };
  };
}
