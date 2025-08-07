{
  config,
  lib,
  pkgs,
  ...
}: let
  opacity = lib.toHexString (((builtins.ceil (config.stylix.opacity.desktop * 100)) * 255) / 100);
in {
  xdg.portal = {
    enable = true;
    config = {
      common.default = [
        "gnome"
      ];
      niri = {
        default = "gnome";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
      obs.default = ["gnome"];
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  programs.niri = {
    settings = {
      hotkey-overlay.skip-at-startup = true;
      xwayland-satellite = {
        enable = true;
      };
      environment = {
        DISPLAY = ":0";
        NIXOS_OZONE_WL = "1";
      };
      outputs."Virtual-1".scale = 1.0;
      outputs."Virtual-1".mode.width = 1920;
      outputs."Virtual-1".mode.height = 1080;
      outputs."Virtual-1".mode.refresh = 60.000;
      outputs."Virtual-1".position.x = 0;
      outputs."Virtual-1".position.y = 0;
      #outputs."eDP-2".position.x = 0;
      #outputs."eDP-2".position.y = 0;
      #outputs."eDP-2".scale = 2.0;
      prefer-no-csd = true;
      layout = {
        gaps = 5;
        border = with config.lib.stylix.colors; {
          enable = true;
          active = {
            gradient = {
              to = "#${base0D}${opacity}";
              from = "#${base0E}${opacity}";
            };
          };
          inactive = {
            color = "#${base03}${opacity}";
          };
        };
        focus-ring.enable = false;
      };

      window-rules = [
        {
          draw-border-with-background = false;
          geometry-corner-radius = let
            r = 5.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
      ];

      input = {
        keyboard.xkb.layout = "uk";
        touchpad = {
          tap = true;
          click-method = "clickfinger";
        };
      };
      spawn-at-startup = [
        {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
        #"${lib.getExe config.default-application.terminal}"
        #"${lib.getExe config.default-application.browser}"
        # TODO: does not show-up
        #"${pkgs.telegram-desktop}/bin/telegram-desktop -startintray"
        # "ironbar"
        # "${pkgs.swww}/bin/swww-daemon"
        #"${pkgs.swaybg}/bin/swaybg -i /home/kpbaks/Pictures/wallpapers/spacehawks.png"
        # "${pkgs.copyq}/bin/copyq"
        # "${pkgs.eww}/bin/eww daemon"
        # "${pkgs.birdtray}/bin/birdtray"
        {command = ["waybar"];}
        # FIXME: does not work
        # "${pkgs.obs-studio}/bin/obs --minimize-to-tray"
      ];
    };
  };
}
