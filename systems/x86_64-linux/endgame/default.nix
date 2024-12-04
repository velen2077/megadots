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
    # Import common hardware files for CPU and SSD.
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  megadots.nixos = {
    apps = {
      sunshine.enable = true;
    };
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
      cachy-kernel.enable = false;
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
  users.users.root.hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
}
