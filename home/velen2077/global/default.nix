{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.homeManagerModules.impermanence
      ./fish.nix
      ./git.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # This setting ensures that user-level systemd services are started correctly
  # when using Home Manager with NixOS. It's a required boilerplate for
  # proper integration.
  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "velen2077";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "25.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "$HOME/Development/megadots";
    };
  };

  home.packages = with pkgs; [
    nixd # Nix LSP.
    alejandra # Nix formatter.
    nixfmt-rfc-style
    nvd # Differ.
    nix-diff # Differ, more detailed.
    nix-output-monitor
    nh # A nice wrapper for managing NixOS and Home Manager.
  ];

  # Global persists for anything that could be global
  # or optional for nixos configs, like Steam.
  home.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "Development"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      ".openvpn"
      ".password-store"
      ".themes"
      ".config/sunshine"
      # dconf is a settings database used by GNOME and other applications.
      # Persisting it ensures your desktop environment's settings are kept.
      ".config/dconf"
      ".local/share/nix"
      ".local/state"
      ".local/share/Steam"
      ".local/share/direnv"
      ".steam"
      ".cache/virt-manager"
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".pki";
        mode = "0700";
      }
      {
        # GnuPG data, essential for encryption and signing.
        directory = ".gnupg";
        mode = "0700";
      }
      {
        # Keyrings store passwords and other secrets for applications.
        # Persisting this is important for not having to log in repeatedly.
        directory = ".local/share/keyrings";
        mode = "0700";
      }
    ];
    files = [
      ".face"
      ".screenrc"
    ];
  };
}
