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
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # inputs.home-manager.nixosModules.home-manager

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ../config/global
    ../config/optional/audio
    ../config/optional/bluetooth
    ../config/optional/cachyos
    ../config/optional/gnome

    # Import required users here.
    ../config/users/velen2077
  ];

  environment.systemPackages = with pkgs; [
    hello
  ];

  networking = {
    hostName = "endgame";
  };

  #boot = {
  # kernelPackages = pkgs.linuxPackages_latest;
  #}#;

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "24.11";
}
