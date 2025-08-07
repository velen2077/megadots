{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];
  programs.niri.enable = true;
  # NOTE: remove this line to switch to latest stable niri release
  #programs.niri.package = pkgs.niri-unstable;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # NOTE: Only enable these if the nixosModules does not work
  # security.pam.services.swaylock = {};
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-gnome
  #   ];
  # };

  services = {
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    envfs.enable = true;
    displayManager.gdm.enable = true;
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
    };
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              rightcontrol = "rightmeta";
            };
            otherlayer = {};
          };
        };
      };
    };
  };
}
