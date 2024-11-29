{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.desktop.gnome;
in {
  options.megadots.nixos.desktop.gnome = with types; {
    enable = mkEnableOption "Whether to enable the GNOME desktop.";
  };

  config = mkIf cfg.enable {
    services.libinput.enable = true;
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    services.xserver.desktopManager.gnome = {
      enable = true;

      extraGSettingsOverrides = "
        # Prefer dark theme
        [org.gnome.desktop.interface]
        color-scheme='prefer-dark'

        # Enable user extensions
        [org.gnome.shell]
        disable-user-extensions=false

        # List of enabled extensions
        [org.gnome.shell]
        enabled-extensions=['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com', 'appindicatorsupport@rgcjonas.gmail.com', 'gsconnect@andyholmes.github.io']

        # Workspace should grow dynamically
        [org.gnome.mutter]
        dynamic-workspaces=true

        # Edge Tiling with mouse
        [org.gnome.mutter]
        edge-tiling=true

        # Never show the notice on tweak
        [org.gnome.tweaks]
        show-extensions-notice=false

        # Show all three button layers
        [org.gnome.desktop.wm.preferences]
        button-layout='appmenu:minimize,maximize,close'
      ";

      extraGSettingsOverridePackages = [
        pkgs.gsettings-desktop-schemas
        pkgs.gnome-shell
      ];
    };

    # Setting daemons
    services = {
      # Udev daemon management
      udev.packages = with pkgs; [gnome-settings-daemon];
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable the DConf configuration system.
    programs.dconf.enable = true;

    # Enabling seahorse keyring
    programs.seahorse = {
      enable = true;
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
      xterm
    ];

    # Enable the Gnome Tweaks tool.
    environment.systemPackages = with pkgs; [
      # Gnome Modding
      dconf-editor
      gnome-tweaks
      gnome-disk-utility
      gnome-tweaks
      nautilus
      gnome-shell
      gnome-terminal
      gnome-shell-extensions
      geary
      gnome-maps
      gnome-calendar
      gnome-contacts

      # Gnome Extensions
      gnome-extensions-cli
      #gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
    ];
  };
}
