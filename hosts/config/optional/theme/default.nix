{pkgs, ...}: {
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.image = ../../../../assets/wallpaper/cyber.jpg;
  stylix.imageScalingMode = "fill";
  stylix.targets.gnome.enable = false;
  stylix.targets.gtk.enable = true;
  stylix.targets.plymouth.enable = true;
  stylix.targets.console.enable = true;
}
