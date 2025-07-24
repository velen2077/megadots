{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # Set the host-specific hostname here.
  networking = {
    hostName = "nixvm";
    domain = "extranet.casa";
  };

  # Set the hosts system state version.
  system.stateVersion = "25.05";

  # Import needed modules here. This is going to pull in my hardware-configuration,
  # global configs (stuff shared between all hosts), optional configs, and
  # my user configs for any users I want added to this host.
  imports = [
    # Import the disko disk configuration for this host.
    ./disks.nix
    # Import the specific hardware-configuration.nix for this host.
    ./hardware-configuration.nix
    # Import my global nixos host configs. These are configs
    # I apply to all my hosts.
    ../../common/core
    # Optional configs to import for this host. If an optional
    # config becomes global, and needs to apply to all my hosts,
    # it gets moved to global.
    ../../common/optional/cachyos.nix
    #../../config/optional/cosmic.nix
    ../../common/optional/ephemeral-btrfs.nix
    ../../common/optional/gnome.nix
    ../../common/optional/graphics.nix
    ../../common/optional/pipewire.nix
    # Import my user configs.
    ../../common/users/velen2077
  ];

  # Boot loader settings are usually unique to my hosts
  # since some systems will dual boot with Windows. For
  # that reason, I keep the boot loader settings in the
  # configuration.nix for each host.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 15;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  # Host specific apps go here. These will only be
  # installed on this host.
  environment.systemPackages = with pkgs; [
    hello
  ];
}
