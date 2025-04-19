{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.system.bluetooth;
in {
  options.megadots.system.bluetooth = {
    enable = mkEnableOption "Enable Bluetooth for the system.";
  };
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    services = {
      # Bluetooth manager
      blueman.enable = true;
    };
  };
}
