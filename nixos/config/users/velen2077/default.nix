{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.velen2077 = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "mysql"
      "network"
      "plugdev"
      "podman"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_ed25519.pub)
    ];
    packages = [pkgs.home-manager];
  };

  home-manager.users.velen2077 = import ../../../../home/velen2077/${config.networking.hostName}.nix;

  environment.persistence."/persist" = {
    users.velen2077 = {
      directories = [
        "Development"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".ansible_inventory"
        ".mozilla"
        ".obsidian"
        ".openvpn"
        ".password-store"
        ".themes"
        ".steam"
        ".config/@filen"
        ".config/sops"
        ".config/vesktop"
        ".config/sops-nix"
        ".config/obsidian"
        ".config/Code"
        ".config/VSCodium"
        ".config/dconf"
        ".config/htop"
        ".config/nvim"
        ".config/obs-studio"
        ".local/share/digikam"
        ".local/share/fish"
        ".local/share/nix"
        ".local/share/nvim"
        ".local/share/Steam"
        ".local/state"
        ".vscode"
        ".vscode-oss"
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
        ".local/share/direnv"
      ];
      files = [
        ".face"
        ".screenrc"
      ];
    };
  };
}
