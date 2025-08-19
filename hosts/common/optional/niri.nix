{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];

  # Setup the niri unstable package.
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services = {
    # needed for GNOME services outside of GNOME Desktop
    displayManager.gdm.enable = true;
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
      libsecret
    ];

    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = lib.mkForce true;
    seahorse.enable = true;
  };

  # NOTE: Only enable these if the nixosModules does not work
  # security.pam.services.swaylock = {};
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-gnome
  #   ];
  # };
}
