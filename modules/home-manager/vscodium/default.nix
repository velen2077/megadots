{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.megadots.vscodium;
in {
  options.megadots.vscodium = {
    enable = mkEnableOption "Enable and customise vscodium.";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        kamadorueda.alejandra
        mvllow.rose-pine
        jnoortheen.nix-ide
        yzhang.markdown-all-in-one
      ];
      userSettings = {
        "git.confirmSync" = "false";
      };
    };
  };
}
