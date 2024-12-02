{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.home.system.impermanence;
in {
  options.megadots.home.system.impermanence = {
    enable = mkEnableOption "Enable and customise impermanence for the user.";
  };

  config = mkIf cfg.enable {
    home.persistence = {
      "/persist/home/velen2077" = {
        allowOther = true;

        directories = [
          "Desktop"
          "Development"
          "Downloads"
          "Documents"
          "Music"
          "Pictures"
          "Public"
          "Templates"
          "Videos"
          "VirtualBox VMs"
          "Trash"
          "Sync"
          ".mozilla"
          ".obsidian"
          ".openvpn"
          ".password-store"
          ".themes"
          ".config/sops"
          ".config/vesktop"
          ".config/sops-nix"
          ".config/obsidian"
          ".config/VSCodium"
          ".config/zsh"
          ".local/share/nix"
          ".local/share/containers"
          ".local/share/Trash"
          ".local/share/TelegramDesktop"
          ".local/share/keyrings"
          ".local/state"
          ".pki"
          ".ssh"
          ".gnupg"
        ];

        files = [
          ".bash_history"
          ".bash_logout"
          ".face"
          ".face.icon"
          ".zsh_history"
          ".cache/cliphist/db"
        ];
      };
    };
  };
}
