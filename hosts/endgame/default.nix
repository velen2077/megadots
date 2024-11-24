{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Import my host-specific hardware configuration.
    ./hardware-configuration.nix
    # Import all NixOS modules to apply them based on
    # the megadots option toggles.
    ../../modules/nixos
    # Import all core NixOS modules to apply them
    # all automatically for this system.
    ../common/core
    # Import all optional NixOS modules. These are
    # then applied using the 'megadots.nixos.optional.<feature>
    # flags to toggle them on or off and supply values if needed.
    ../common/optional
    # Import the users required for this system.
    ../common/users/velen2077
  ];

  # Here is where the fun happens. All the modules should
  # be loaded at import, and they can be toggled on or
  # off using the appropriate option.
  megadots.nixos.optional = {
    gaming.enable = true;
    gnome.enable = true;
    kernel = {
      cachy.enable = true;
    };
    nvidia.enable = true;
    packages.enable = true;
  };

  # Set the hostname for this system.
  networking = {
    hostName = "endgame";
    useDHCP = lib.mkDefault true;
  };

  # Apply Stylix styling to this system for colour scheming
  # and wallpaper. This applies globally to the system.
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ../../assets/wallpapers/monokai.jpeg;
  stylix.imageScalingMode = "fill";
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  # Set the system cursor type. I like Bibata Modern Classic.
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # The system state version for this device.
  system.stateVersion = "25.05";
}
