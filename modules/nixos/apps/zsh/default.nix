{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.apps.zsh;
in {
  options.megadots.apps.zsh = {
    enable = mkEnableOption "Enable zsh.";
  };
  config = mkIf cfg.enable {
    programs = {
      command-not-found.enable = true;

      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        history.ignoreDups = true; # Do not enter command lines into the history list if they are duplicates of the previous event.
        prezto = {
          git.submoduleIgnore = "untracked"; # Ignore submodules when they are untracked.
        };

        sessionVariables = {
          NIX_AUTO_RUN = true;
        };
        oh-my-zsh = {
          enable = true;
          plugins = [
            "command-not-found"
            "cp"
            "direnv"
            "dotenv"
            "extract"
            "git"
            "systemd"
          ];
        };
      };
    };
  };
}
