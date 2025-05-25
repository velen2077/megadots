{
  inputs,
  outputs,
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
    #./disks.nix
    # Import the specific hardware-configuration.nix for this host.
    ./hardware-configuration.nix
    # Import my nixos host configs. Both core and optional.
    # Optionals are enabled on a per config basis using the
    # megadots options. This includes user configs.
    ../../config/global
    # Optional configs to import.
    ../../config/optional/encrypted-root.nix
    ../../config/optional/ephemeral-btrfs.nix
    ../../config/optional/gnome.nix
    ../../config/optional/quietboot.nix
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

  # Set the hosts system state version.
  system.stateVersion = "25.05";
}
