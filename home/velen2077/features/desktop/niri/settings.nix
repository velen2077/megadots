{
  config,
  pkgs,
  ...
}: {
  programs.niri = {
    #enable = true;
    #package = pkgs.niri;

    settings = {
      animations.enable = false;
      xwayland-satellite = {
        enable = true;
      };
      workspaces = {
        "web" = {};
        "code" = {};
        "virt" = {};
        "chat" = {};
        "music" = {};
        "game" = {};
      };

      prefer-no-csd = true;

      hotkey-overlay = {
        skip-at-startup = true;
      };

      layout = {
        background-color = "#00000000";

        focus-ring = {
          enable = true;
          width = 3;
          active = {
            color = "#A8AEFF";
          };
          inactive = {
            color = "#505050";
          };
        };

        gaps = 4;

        struts = {
          left = 4;
          right = 4;
          top = 4;
          bottom = 4;
        };

        center-focused-column = "on-overflow";
        default-column-width = {proportion = 0.5;};
      };

      input = {
        keyboard.xkb.layout = "uk";
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
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = false;
      };

      outputs = {
        "Virtual-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.000;
          };
          scale = 1.0;
          position = {
            x = 0;
            y = 0;
          };
        };
      };

      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        DISPLAY = ":0";
      };
    };
  };
}
