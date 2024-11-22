{
  config,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ../../../assets/wallpapers/monokai.jpeg;
  stylix.imageScalingMode = "fill";
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

  # see also common/fonts.nix
  # stylix.fonts = {
  #   serif = {
  #     package = pkgs.nerdfonts.override {fonts = ["IosevkaTermSlab"];};
  #     name = "IosevkaTermSlab";
  #   };
  #   sansSerif = {
  #     package = pkgs.nerdfonts.override {fonts = ["Arimo"];};
  #     name = "Arimo";
  #   };
  #   monospace = {
  #     package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
  #     name = "Iosevka";
  #   };
  #   emoji = {
  #     package = pkgs.openmoji-color;
  #     name = "OpenMoji Color";
  #   };
  # };
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  # gtk.iconTheme = {
  #   package = pkgs.adwaita-icon-theme;
  #   name = "Adwaita";
  # };
}
