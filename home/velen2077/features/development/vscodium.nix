{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          kamadorueda.alejandra
          mvllow.rose-pine
          jnoortheen.nix-ide
          yzhang.markdown-all-in-one
        ];
        userSettings = {
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "git.autofetch" = true;
          "workbench.colorTheme" = "Rosé Pine (no italics)";
          "explorer.confirmDragAndDrop" = false;
        };
      };
    };
  };
}
