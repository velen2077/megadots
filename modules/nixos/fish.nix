{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.fish;
in {
  options.megadots.fish = {
    enable = mkEnableOption "Enable fish shell.";
  };

  config = mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;
        vendor = {
          completions.enable = true;
          config.enable = true;
          functions.enable = true;
        };
      };
    };
  };
}
