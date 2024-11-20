{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.gnome;
in {
  options.megadots.gnome = {
    enable = mkEnableOption "Enable the GNOME desktop environment.";
  };

  config = mkIf cfg.enable {
    services.libinput.enable = true;
    # To fix GTK apps:
    programs.dconf.enable = true;
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      cheese # webcam tool
      gnome-music
      # text editor
      epiphany # web browser
      geary # email reader
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
    ];

    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];

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
