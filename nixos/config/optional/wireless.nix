{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/bluetooth"
    ];
  };
}
