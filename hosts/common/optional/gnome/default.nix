{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    gnome.games.enable = false;
  };
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
  # Fix broken stuff
  services.avahi.enable = false;
  networking.networkmanager.enable = false;
}
