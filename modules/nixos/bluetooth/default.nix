{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.bluetooth;
in {
  options.megadots.bluetooth = {
    enable = mkEnableOption "Enable bluetooth for the system.";
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
