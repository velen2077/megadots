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
    # Import theme.
    ./theme.nix
    # Import my global nixos host configs. These are configs
    # I apply to all my hosts.
    ../../config/global
    # Optional configs to import for this host. If an optional
    # config becomes global, and needs to apply to all my hosts,
    # it gets moved to global.
    ../../config/optional/cachyos.nix
    ../../config/optional/gaming.nix
    ../../config/optional/gnome.nix
    ../../config/optional/impermanence.nix
    ../../config/optional/pipewire.nix
    ../../config/optional/quietboot.nix
    ../../config/optional/virtman.nix
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
      windows = {
        "windows" = let
          # To determine the name of the windows boot drive, boot into edk2 first, then run
          # `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
          # which alias corresponds to which EFI partition.
          boot-drive = "FS2";
        in {
          title = "Windows";
          efiDeviceHandle = boot-drive;
          sortKey = "y_windows";
        };
      };
      # edk2 can be used to determine the Windows boot-drive value.
      # I disable it after I've got the code as it is no longer
      # needed, but I like to leave it in my configs.
      edk2-uefi-shell.enable = false;
      edk2-uefi-shell.sortKey = "z_edk2";
    };
  };

  # Set the host-specific hostname here.
  networking = {
    hostName = "endgame";
    domain = "extranet.casa";
  };

  # Host specific apps go here. These will only be
  # installed on this host.
  environment.systemPackages = with pkgs; [
    hello
  ];

  # Set the hosts system state version.
  system.stateVersion = "25.05";
}
