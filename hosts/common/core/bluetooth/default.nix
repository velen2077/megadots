{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
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
}
