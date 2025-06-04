{
  # Boot loader settings are usually unique to my hosts
  # since some systems will dual boot with Windows. For
  # that reason, I keep the generic boot loader settings
  # here, and supply the custom options in the
  # configuration.nix for each host that needs it.

  # Enable initrd with systemd.
  boot.initrd.systemd.enable = true;

  # Enable systemd-boot with timeout. This is my default
  # bootloader and needed for my various configs such
  # as impermanence and other dependent services.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 30;
    systemd-boot = {
      # Only show up to 10 generations in the boot menu.
      configurationLimit = 10;
      enable = true;
    };
  };
}
