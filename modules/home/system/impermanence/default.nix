{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.home.system.impermanence;
in {
  options.megadots.home.system.impermanence = with types; {
    enable = mkEnableOption "Whether to enable impermanence.";
  };

  config = mkIf cfg.enable {
    home.persistence."/persist/home/velen2077" = {
      directories = [
        "Documents"
        "Development"
        "Downloads"
        "Music"
        "Pictures"
        "Templates"
        "Videos"
        ".config/vesktop"
        # GPG keys and metadata.
        ".gnupg"
        # SSH keys and config.
        ".ssh"
        # Firefox data, essentially a cache plus auth stuff.
        ".mozilla"
        # Fish history and completions
        ".local/share/fish"
        # nix profile and any other data Nix wants to store there.
        ".local/state/nix"
      ];
      files = [
        # Nix cache config
        ".config/nix/nix.conf"
        # GitHub CLI auth
        ".config/gh/hosts.yml"
        # zsh history.
        ".zsh_history"
        ".zshenv"
      ];
      # > allows other users, such as `root`, to access files through the bind
      # > mounted directories listed in `directories`.
      allowOther = true;
    };
  };
}
