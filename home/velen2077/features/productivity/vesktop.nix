{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.vesktop;
in {
  options.megadots.optional.vesktop = {
    enable = mkEnableOption "Enable vesktop and customisations.";
  };

  config = mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
    };
  };
}
