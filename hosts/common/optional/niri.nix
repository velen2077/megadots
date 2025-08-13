{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];

  # Setup the niri unstable package.
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  # Use the following xdg portals for my niri config.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  # Needed for hyprlock.
  security.pam.services.hyprlock = {};
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;
  environment.systemPackages = [pkgs.libsecret];
  # Services required for my niri config.
  services = {
    gnome.gnome-keyring.enable = true;
    envfs.enable = true;
    displayManager.gdm.enable = true;
  };

  # Environment variables to use within the niri
  # window manager.
  environment.variables = {
    XDG_SESSION_DESKTOP = "niri";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_RUNTIME_DIR = "/run/user/$UID";
    NIXOS_OZONE_WL = "1";
    USE_WAYLAND_GRIM = "0";
  };
}
