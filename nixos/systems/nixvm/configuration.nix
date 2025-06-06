# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Set the essential options for this host before I do
  # anything else. Hostname and domain are used in global
  # configs so must be accurate.
  networking = {
    hostName = "nixvm";
    domain = "extranet.casa";
  };

  # Import my configurations.
  imports = [
    # Import my generated (nixos-generate-config) hardware configuration.
    # for this host. This should always be unique to a host.
    ./hardware-configuration.nix
    # Import my disko disk config for this host.
    ./disks.nix
    # Import my global host configs. These should apply to every
    # every host and contain important defaults.
    ../../modules/global
    # Import the optional configurations I want to apply to this
    # specific host.
    #../../modules/optional/cachyos.nix
    #../../modules/optional/gaming.nix
    #../../modules/optional/gnome.nix
    #../../modules/optional/persistence.nix
    #../../modules/optional/pipewire.nix
    #../../modules/optional/theme.nix
    #../../modules/optional/virtmanager.nix
    #../../modules/optional/wireless.nix
    # Import the users for this system.
    ../../modules/users/velen2077
  ];

  megadots = {
    bluetooth.enable = true;
    cachyos.enable = true;
    ephemeral-btrfs = {
      enable = true;
      diskLabel = "nixos";
    };
    fish.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    graphics.enable = true;
    locale = {
      enable = true;
      timezone = "Europe/London";
      locale = "en_GB";
      keyboardLayout = "gb";
      consoleKeyMap = "uk";
    };
    persistence.enable = true;
    pipewire.enable = true;
    theme.enable = true;
    thermald.enable = true;
    upower.enable = true;
    virt-manager.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
