# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./firewall.nix
      ./fish.nix
      ./gamemode.nix
      ./locale.nix
      ./nix-ld.nix
      ./nix.nix
      ./openssh.nix
      ./persistence.nix
      ./steam-hardware.nix
      ./systemd-initrd.nix
      ./thermald.nix
      ./upower.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # Apps installed on all hosts go here.
  environment.systemPackages = with pkgs; [
    age
    alejandra
    fastfetch
    git
    just
    sops
    xorg.xrandr
    game-devices-udev-rules
  ];

  # Enable adb and dconf for the host.
  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.uinput.enable = true;

  # Allow users to mount removable drives.
  services.udisks2.enable = true;

  # Mark admins as trusted users.
  nix.settings.trusted-users = [
    "@wheel"
  ];

  # Enable passwordless sudo for members
  # of wheel group.
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  # Cleanup stuff included by default
  services.speechd.enable = lib.mkDefault false;
}
