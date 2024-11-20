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
    # Common hardware imports.
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    # My additional host-specific imports.
    ./hardware-configuration.nix
    # NixOS module imports.
    ../../modules/nixos
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
  networking.domain = "extranet.click";

  # Cleanup stuff included by default.
  services.speechd.enable = lib.mkForce false;

  networking = {
    hostName = hostname;
    useDHCP = lib.mkForce true;
  };

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;

  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    shell = pkgs.zsh;
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

  # This is only used when building and running a test
  # virtual machine to validate my config before switching.
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };

  megadots = {
    audio.enable = true;
    bluetooth.enable = true;
    gaming.enable = true;
    gnome.enable = false;
    kde.enable = true;
    cachyKernel.enable = true;
    packages.enable = true;
  };

  system.stateVersion = stateVersion;
}
