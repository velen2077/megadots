{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../common/core
    ../common/optional
    ../common/users/velen2077
  ];

  megadots.nixos.optional = {
    gaming.enable = true;
    gnome.enable = true;
    kernel = {
      cachy.enable = true;
    };
    nvidia.enable = true;
    packages.enable = true;
  };

  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ../../assets/wallpapers/monokai.jpeg;
  stylix.imageScalingMode = "fill";
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  system.stateVersion = "25.05";
}
