{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.hardware.bluetooth;
in {
  options.megadots.nixos.hardware.bluetooth = {
    enable = mkEnableOption "Whether to enable bluetooth for the system.";
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
