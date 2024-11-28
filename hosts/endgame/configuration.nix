{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Import common hardware files for CPU and SSD.
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    # Import all NixOS modules to apply them based on
    # the megadots option toggles.
    outputs.nixosModules
    outputs.nixosModulesCommon
    outputs.nixosModulesOptional
    outputs.nixosModulesUsers
    # Import my host-specific hardware configuration.
    ./hardware-configuration.nix
    # Import all core NixOS modules to apply them
    # all automatically for this system.
    #../common/core
    # Import all optional NixOS modules. These are
    # then applied using the 'megadots.nixos.optional.<feature>
    # flags to toggle them on or off and supply values if needed.
    #../common/optional
    # Import the users required for this system.
    #../common/users/velen2077
  ];

  # Here is where the fun happens. All the modules should
  # be loaded at import, and they can be toggled on or
  # off using the appropriate option.
  megadots.host = {
    # User host module enablement goes here. These
    # are modules that live in the hosts/modules/userss
    # directory and toggled using the relevant options.
    # The option name is the users name.
    users = {
      velen2077.enable = true;
    };
    # Optional host module enablement goes here. These
    # are modules that live in the hosts/modules/optional
    # directory and toggled using the relevant options.
    optional = {
      gnome.enable = true;
    };
  };
  # Set the bootloader preferences.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.editor = false;
  };

  # Set the hostname for this system.
  networking = {
    hostName = "endgame";
    useDHCP = lib.mkDefault true;
    domain = "extranet.click";
  };

  # The system state version for this device.
  system.stateVersion = "24.05";
}
