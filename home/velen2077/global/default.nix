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
    nh # Nice wrapper for NixOS and HM.
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
      ".config/sops"
      ".config/sops-nix"
      ".config/sunshine"
      ".config/dconf"
      ".local/share/nix"
      ".local/state"
      ".local/share/Steam"
      ".local/share/direnv"
      ".steam"
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".pki";
        mode = "0700";
      }
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".nixops";
        mode = "0700";
      }
      {
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
