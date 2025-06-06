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
    enable = mkEnableOption "Enable bluetooth.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    environment.persistence."/persist" = mkIf config.megadots.persistence.enable {
      directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
