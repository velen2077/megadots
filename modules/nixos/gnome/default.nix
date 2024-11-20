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
  };
}
