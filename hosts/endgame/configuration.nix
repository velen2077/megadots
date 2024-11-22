{
  config,
  hostname,
  inputs,
  lib,
  outputs,
  pkgs,
  username,
  stateVersion,
  ...
}: {
  imports = [
    # Common hardware imports. See the link to view
    # what is applied here in these inputs.
    # https://github.com/NixOS/nixos-hardware/tree/master/common
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    # My host-specific hardware configuration.
    ./hardware-configuration.nix
    ./stylix
    # NixOS module imports.
    ../../modules/nixos
  ];

  # Here is where the fun happens. All the modules should
  # be loaded at build time, and they can be toggled on or
  # off using the appropriate option.
  megadots = {
    audio.enable = true;
    bluetooth.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    kde.enable = false;
    kernel.cachy.enable = false;
    nvidia.enable = true;
    packages.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Optimize storage and automatic scheduled Garbage Collection.
  # If you want to run GC manually, use commands:
  # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths.
  # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths.
  # `nix-collect-garbage -d` for deleting old generations of user profiles.
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  hardware.enableRedistributableFirmware = true;
  networking.domain = "extranet.click";

  # Set the power governor to performance mode.
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Cleanup stuff included by default.
  services.speechd.enable = lib.mkForce false;

  networking = {
    hostName = hostname;
    useDHCP = lib.mkForce true;
  };

  # Needed for GPG signing.
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;

  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    shell = pkgs.zsh;
    icon = ../../assets/avatars/velen2077.png;
    extraGroups = [
      "audio"
      "git"
      "libvirtd"
      "lxd"
      "network"
      "video"
      "wheel"
      "wireshark"
    ];

    #openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/gabriel/ssh.pub);
    #hashedPasswordFile = config.sops.secrets.gabriel-password.path;
    packages = [pkgs.home-manager];
  };

  # Set the time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure additional locales.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Update the xkb layout to British.
  services.xserver = {
    xkb.layout = "gb";
  };

  # Configure console keymap.
  console.keyMap = "uk";

  # Set the bootloader preferences.

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.editor = false;
  };

  # This is only used when building and running a test
  # virtual machine to validate my config before switching.
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };

  system.stateVersion = stateVersion;
}
