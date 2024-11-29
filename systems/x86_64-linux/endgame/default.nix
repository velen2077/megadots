{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  systems,
  config,
  ...
}: {
  # This is the main configuration file for my desktop
  # gaming PC (AMD Ryzen 7800X3D, NVIDIA 4070Ti).
  imports = [
    ./hardware-configuration.nix
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
