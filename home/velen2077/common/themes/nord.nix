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
    image = ../../../../assets/wallpaper/orbit.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";

    opacity = {
      desktop = 1.0;
      popups = 1.0;
      terminal = 1.0;
    };

    fonts = {
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };

      monospace = {
        package = pkgs.geist-font;
        name = "GeistMono";
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    targets = {
      firefox = {
        profileNames = ["default"];
      };
      #waybar.enable = false;
      #vscode.enable = false;
    };
  };

  gtk.iconTheme = {
    name = "Colloid";
    package = pkgs.colloid-icon-theme;
  };

  home.packages = [pkgs.noto-fonts-cjk-sans];
}
