{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.home.optional.zsh;
in {
  options.megadots.home.optional.zsh = {
    enable = mkEnableOption "Enable zsh customisation.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
      };

      history = {
        save = 1000;
        size = 1000;
      };

      shellAliases = {
        c = "clear";
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
