{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.packages.zsh;
in {
  options.megadots.packages.zsh = {
    enable = mkEnableOption "Enable zsh.";
  };
  config = mkIf cfg.enable {
    programs = {
      command-not-found.enable = true;

      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;

        ohMyZsh = {
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
