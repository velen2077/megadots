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
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    configPackages = [pkgs.niri];
  };
  # Some services, like blueman-applet, require a `tray` target. Typically Home
  # Manager sets this target in WM modules, but it's not set up for Niri yet.
  systemd.user.targets.tray = {
    Unit = {
      After = ["niri.service"];
    };
    Install = {
      WantedBy = ["niri.service"];
    };
  };

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  # Switch from `Install.WantedBy = [ "graphical-session.target" ]` as defined
  # in the service file provided by the xwayland-satellite package. This links
  # xwayland-satellite to niri specifically, and schedules it so that there is
  # a wayland session available when it starts.
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = "graphical-session.target";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      StandardOutput = "journal";
    };
    Install.WantedBy = ["niri.service"];
  };

  # Use Gnome Keyring as SSH agent.
  services.gnome-keyring = {
    enable = true;
    components = ["pkcs11" "secrets" "ssh"];
  };
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

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
              to = "#${base0A}${opacity}";
              from = "#${base08}${opacity}";
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

      workspaces = {
        "01-web" = {name = "web";};
        "02-code" = {name = "code";};
        "03-virt" = {name = "virt";};
        "04-chat" = {name = "chat";};
        "05-music" = {name = "music";};
        "05-gaming" = {name = "gaming";};
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
        {
          matches = [
            {
              at-startup = true;
              app-id = "^firefox$";
            }
          ];
          open-maximized = true;
          open-on-workspace = "web";
        }
        {
          matches = [
            {
              at-startup = true;
              app-id = "^codium$";
            }
          ];
          open-maximized = true;
          open-on-workspace = "code";
        }
        {
          matches = [
            {
              at-startup = true;
              app-id = "^virt-manager$";
            }
          ];
          open-on-workspace = "virt";
        }
        {
          matches = [
            {
              at-startup = true;
              app-id = "^vesktop$";
            }
          ];
          open-maximized = true;
          open-on-workspace = "chat";
        }
        {
          matches = [
            {
              at-startup = true;
              app-id = "^spotify$";
            }
          ];
          open-maximized = true;
          open-on-workspace = "music";
        }
        {
          matches = [
            {
              at-startup = true;
              app-id = "^steam$";
            }
          ];
          open-maximized = true;
          open-on-workspace = "gaming";
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
