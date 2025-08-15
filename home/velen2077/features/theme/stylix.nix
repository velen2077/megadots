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
    image = ../../../../assets/wallpaper/overwatch.jpg;

    targets = {
      firefox = {
        profileNames = ["default"];
      };
    };
  };
}
