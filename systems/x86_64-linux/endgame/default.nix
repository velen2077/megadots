{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  inputs,
  lib,
  systems,
  config,
  ...
}: {
  # This is the main configuration file for my desktop
  # gaming PC (AMD Ryzen 7800X3D, NVIDIA 4070Ti).
  imports = [
    # Import my host-specific hardware configuration.
    ./hardware-configuration.nix
    # Import disko config.
    ./disk-config.nix
    # Import impermanence settings.
    ./impermanence.nix
    # Import common hardware files for CPU and SSD.
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  megadots.nixos = {
    desktop = {
      gnome.enable = true;
    };
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      nvidia.enable = true;
    };
    packages = {
      common.enable = true;
      development.enable = true;
      gaming.enable = true;
    };
    security = {
      firewall.enable = true;
    };
    services = {
      ssh.enable = true;
    };
    system = {
      boot.enable = true;
      cachy-kernel.enable = true;
      impermanence.enable = true;
      locale.enable = true;
      nix = {
        enable = true;
        stateVersion = "24.11";
      };
      virtualisation.enable = true;
    };
    users = {
      velen2077.enable = true;
    };
  };
}
