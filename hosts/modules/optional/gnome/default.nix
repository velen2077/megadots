{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.host.optional.gnome;
in {
  options.megadots.host.optional.gnome = {
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
      gnome.cheese # webcam tool
      gnome.gnome-music
      # text editor
      epiphany # web browser
      gnome.geary # email reader
      gnome.gnome-characters
      gnome.tali # poker game
      gnome.iagno # go game
      gnome.hitori # sudoku game
      gnome.atomix # puzzle game
      gnome.yelp # Help view
      gnome.gnome-contacts
      gnome.gnome-initial-setup
    ];

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };
}
