{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  wallpaper = ../../../assets/wallpaper/robogirl.png;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
    image = wallpaper;
    polarity = "dark";
  };
}
