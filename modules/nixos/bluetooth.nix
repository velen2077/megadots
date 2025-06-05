{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.bluetooth;
in {
  options.megadots.bluetooth = {
    enable = mkEnableOption "the foo program";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    environment.persistence."/persist" = {
      directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
