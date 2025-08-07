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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    polarity = "dark";
    #image = ../../../../../assets/wallpaper/overwatch.png;

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
