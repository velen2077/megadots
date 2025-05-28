{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable dconf so it can be configured by home-manager.
  programs.dconf.enable = true;

  xdg.portal.enable = true;

  services = {
    libinput.enable = true;
    xserver = {
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
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

  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-tweaks
  ];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/AccountsService"
    ];
    files = [
    ];
  };
}
