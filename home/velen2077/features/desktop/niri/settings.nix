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
  programs.niri = {
    settings = {
      hotkey-overlay.skip-at-startup = true;
      xwayland-satellite = {
        enable = true;
      };
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      spawn-at-startup = [
        {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
        {command = ["waybar"];}
      ];
      input = {
        keyboard.xkb.layout = "gb";
        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };
        focus-follows-mouse = {
          enable = false;
          max-scroll-amount = "90%";
        };
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };
      # Monitor config.
      outputs = outputs;
      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };
      prefer-no-csd = true;
      layout = {
        focus-ring.enable = false;
        border = with config.theme.colors; {
          enable = true;
          width = config.theme.spacing.xs;
          active = {
            gradient = {
              to = "#${base0A}${opacity}";
              from = "#${base08}${opacity}";
            };
          };
          inactive = {
            color = "#${base03}${opacity}";
          };
        };
        shadow = {
          enable = false;
        };
        preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {proportion = 0.5;};

        gaps = config.theme.spacing.xs;
        struts = {
          left = 0;
          right = 0;
          top = -5;
          bottom = 0;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
    };
  };
}
