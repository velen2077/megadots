{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.users.velen2077;
in {
  options.megadots.nixos.users.velen2077 = with types; {
    enable = mkEnableOption "Whether to enable the user velen2077.";
  };

  config = mkIf cfg.enable {
    users.users.velen2077 = {
      isNormalUser = true;
      hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
      description = "velen2077";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      createHome = true;
      shell = pkgs.zsh;
      packages = with pkgs; [zsh];
      openssh.authorizedKeys.keys = [
        (builtins.readFile ./id_ed25519.pub)
      ];
    };
    programs.zsh.enable = true;
    environment.persistence."/persist" = {
      enable = true; # NB: Defaults to true, not needed
      hideMounts = true;
      users.velen2077 = {
        directories = [
          "Development"
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "Templates"
          ".mozilla"
          ".config/vesktop"
          ".config/VSCodium"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
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
          ".screenrc"
          ".zshenv"
          ".zsh_history"
        ];
      };
    };
  };
}
