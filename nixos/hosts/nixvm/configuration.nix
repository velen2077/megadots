{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # Import needed modules here. This is going to pull in my hardware-configuration,
  # global configs (stuff shared between all hosts), optional configs, and
  # my user configs for any users I want added to this host.
  imports = [
    # Import the relevant common hardware modules from the hardware flake
    # for this specific host.
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    # Import the disko disk configuration for this host.
    ./disks.nix
    # Import the specific hardware-configuration.nix for this host.
    ./hardware-configuration.nix
    # Import my global nixos host configs. These are configs
    # I apply to all my hosts.
    ../../config/global
    # Optional configs to import for this host. If an optional
    # config becomes global, and needs to apply to all my hosts,
    # it gets moved to global.
    ../../config/optional/cachyos.nix
    ../../config/optional/gnome.nix
    ../../config/optional/impermanence.nix
    ../../config/optional/pipewire.nix
    ../../config/optional/quietboot.nix
    ../../config/optional/wireless.nix
    # Import my user configs.
    ../../config/users/velen2077
  ];

  # Boot loader settings are usually unique to my hosts
  # since some systems will dual boot with Windows. For
  # that reason, I keep the boot loader settings in the
  # configuration.nix for each host.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 30;
    systemd-boot = {
      enable = true;
    };
  };

  # Set the host-specific hostname here.
  networking = {
    hostName = "nixvm";
  };

  # Host specific apps go here. These will only be
  # installed on this host.
  environment.systemPackages = with pkgs; [
    hello
  ];

  # Set the hosts system state version.
  system.stateVersion = "25.05";
}
