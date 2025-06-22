# This module enables the COSMIC desktop environment.
# It is based on the community-maintained nixos-cosmic flake.
{inputs, ...}: {
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  # Enable the COSMIC desktop environment.
  services.desktopManager.cosmic.enable = true;

  # Enable the COSMIC greeter (login screen).
  # This is recommended over using gdm or other display managers.
  services.displayManager.cosmic-greeter.enable = true;
}
