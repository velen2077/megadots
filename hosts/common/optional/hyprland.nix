{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  xdg.portal = with pkgs; {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      hyprland.default = ["hyprland"];
    };
    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.greetd = {
    enable = true;
    restart = false;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd Hyprland --time-format '%F %R'";
        user = "greeter";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    greetd-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    wayland
    wl-clipboard
  ];

  # Configure xwayland
  services.xserver = {
    displayManager.startx = {
      enable = true;
    };
  };
}
