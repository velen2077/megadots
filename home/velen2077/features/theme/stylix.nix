{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    polarity = "dark";

    targets = {
      firefox = {
        profileNames = ["default"];
      };
      #mako.enable = false;
      waybar.enable = false;
      #waybar.enable = false;
      #vscode.enable = false;
    };
  };
}
