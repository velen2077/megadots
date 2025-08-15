{
  config,
  lib,
  pkgs,
  ...
}: let
  opacity = lib.toHexString (((builtins.ceil (config.stylix.opacity.desktop * 100)) * 255) / 100);
  enabledMonitors = builtins.filter (m: m.enabled) config.monitors;
  outputs = lib.genAttrs (map (m: m.name) enabledMonitors) (
    name: let
      monitor = lib.findFirst (m: m.name == name) (throw "Monitor not found") enabledMonitors;
    in {
      scale = monitor.scale;
      mode = {
        width = monitor.width;
        height = monitor.height;
        refresh = monitor.refreshRate;
      };
      position =
        if monitor.position == "auto"
        then null
        else {
          x = 0;
          y = 0;
        };
    }
  );
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
      # Monitor config.
      outputs = outputs;
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
        struts = {
          top = -5;
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
        keyboard = {
          xkb.layout = "gb";
        };
        touchpad = {
          tap = true;
          click-method = "clickfinger";
        };
      };
      spawn-at-startup = [
        {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
        {command = ["waybar"];}
      ];
    };
  };
}
