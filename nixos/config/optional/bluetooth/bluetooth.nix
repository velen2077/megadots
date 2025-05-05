{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.bluetooth;
in {
  options.megadots.optional.bluetooth = {
    enable = mkEnableOption "Enable bluetooth.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
    };
  };
}
