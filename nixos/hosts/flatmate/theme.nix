{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  wallpaper = ../../../assets/wallpaper/overwatch.jpg;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    image = wallpaper;
    polarity = "dark";
  };
}
