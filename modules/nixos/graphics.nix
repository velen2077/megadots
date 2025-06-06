{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.graphics;
in {
  options.megadots.graphics = {
    enable = mkEnableOption "Enable graphics acceleration.";
  };

  config = mkIf cfg.enable {
    # Required for amd graphics.
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
