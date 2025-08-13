{
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
  };

  services = {
    blueman.enable = true;
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/bluetooth"
    ];
  };
}
