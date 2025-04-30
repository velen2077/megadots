{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.gnome;
in {
  options.megadots.optional.gnome = {
    enable = mkEnableOption "Enable gnome.";
  };

  config = mkIf cfg.enable {
    # To fix GTK apps:
    programs.dconf.enable = true;

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
      gnome-tweaks
    ];
  };
}
