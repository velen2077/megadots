{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {
  # Set the host-specific hostname here.
  networking = {
    hostName = "endgame";
    domain = "extranet.casa";
  };

  # Set the hosts system state version.
  system.stateVersion = "25.05";

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
    ../../common/core
    # Optional configs to import for this host. If an optional
    # config becomes global, and needs to apply to all my hosts,
    # it gets moved to global.
    ../../common/optional/cachyos.nix
    ../../common/optional/ephemeral-btrfs.nix
    ../../common/optional/gaming.nix
    ../../common/optional/graphics.nix
    ../../common/optional/lanzaboote.nix
    ../../common/optional/minecraft.nix
    ../../common/optional/pipewire.nix
    ../../common/optional/razer.nix
    ../../common/optional/virt-manager.nix
    ../../common/optional/wireless.nix
    # Import my user configs.
    ../../common/users/velen2077
    # Import my desktop.
    ../../common/optional/gnome.nix
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
    kernelParams = [];
  };

  hardware.amdgpu.initrd.enable = true; # load amdgpu kernelModules in stage 1.
  hardware.amdgpu.opencl.enable = true; # OpenCL support - general compute API for gpu
  hardware.amdgpu.amdvlk.enable = true; # additional, alternative drivers.

  # Host specific apps go here. These will only be
  # installed on this host.
  environment.systemPackages = with pkgs; [
    hello
    lact
    clinfo # opencl testing
    vulkan-tools # vulkaninfo
    ipmiview
    unetbootin
  ];
}
