# This file (and the global directory) holds config that i use on all hosts
{
  config,
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
      ./locale.nix
      ./persistence.nix
      ./services.nix
      ./ssh.nix
      ./systemd-initrd.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useUserPackages = true;
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

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = ["@wheel"];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      warn-dirty = false;

      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Delete generations that haven't been activated in
      # over 30 days.
      options = "--delete-older-than +30";
    };
  };

  programs.nix-ld = {
    enable = true;
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
