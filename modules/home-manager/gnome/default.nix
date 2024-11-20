{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.megadots.gnome;
in {
  config = mkIf cfg.enable {
    # Configure Cursor Theme
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # Theme GTK
    gtk = {
      enable = true;
      # # font = {
      # #   name = "Source Han Serif";
      # #   size = 10;
      # #   package = pkgs.source-han-serif;
      # # };
      # theme = {
      #   name = "${config.colorScheme.slug}";
      #   package = nix-colors-lib.gtkThemeFromScheme {scheme = config.colorScheme;};
      # };
      # iconTheme = {
      #   name = "Papirus-Dark";
      #   package = pkgs.papirus-icon-theme;
      # };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    # Theme QT -> GTK
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
