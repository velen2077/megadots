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
      # Import the Home Manager impermanence module in case
      # we have it declared for our system.
      inputs.impermanence.homeManagerModules.impermanence
      # Import all cli features for this user on this host.
      # You can be granular here if you don't want to import
      # all features. Just specify the nix files individually
      # if needed. I import the folder so that the default.nix
      # imports all features in the folder.
      ../features/cli
    ]
    # Include any custom Home Manager modules I have defined.
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      extra-substituters = [
        "https://chaotic-nyx.cachix.org/"
        "https://cosmic.cachix.org/"
        "https://niri.cachix.org/"
      ];
      extra-trusted-public-keys = [
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
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

  # Set up my Home Manager instance.
  home = {
    username = lib.mkDefault "velen2077";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "25.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "$HOME/Development/megadots";
    };
  };

  # Include some packages by default. I typically
  # include anything I need to work with nix.
  home.packages = with pkgs; [
    nixd # Nix LSP.
    alejandra # Nix formatter.
    nixfmt-rfc-style # Another nix formatter.
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
      ".config/dconf"
      ".config/openrazer"
      ".config/polychromatic"
      ".local/share/nix"
      ".local/state"
      ".local/share/Steam"
      ".local/share/direnv"
      ".local/share/PrismLauncher"
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
