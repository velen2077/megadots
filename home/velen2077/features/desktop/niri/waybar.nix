{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";

        modules-left = ["niri/workspaces"];
        modules-center = [];
        modules-right = [
          "custom/cpu"
          "cpu"
          "custom/separator"
          "custom/gpu"
          "custom/separator"
          "clock"
          "custom/separator"
          "battery"
          "tray"
        ];

        spacing = config.theme.spacing.s;

        "niri/workspaces" = {
          format = "{name}";
          on-scroll-up = "niri msg action focus-workspace-up";
          on-scroll-down = "niri msg action focus-workspace-up";
        };

        "custom/separator" = {
          format = "󰿟";
          tooltip = false;
        };

        "battery" = {
          interval = 60;
          states = {
            warning = 30;
            critical = 16;
          };

          format = "[{capacity}%] 󰿟";
        };

        "cpu" = {
          interval = 1;
          format = "{usage}%";
          max-length = 10;
        };

        "custom/cpu" = {
          format = "CPU: {text}°C";
          exec = "cpu-temp";
          return-type = "json";
          interval = 5;
          cursor = 68;
          tooltip = false;
        };

        "custom/gpu" = {
          format = "GPU: {text}°C";
          exec = "gpu-temp";
          return-type = "json";
          interval = 5;
          cursor = 68;
          tooltip = false;
        };

        clock = {
          format = "{:%H:%M / %d-%m-%Y}";
          tooltip-format = "{:%A, %d %b %Y, %H:%M}";
          on-click = "xdg-open https://calendar.google.com/";
        };

        tray = {
          spacing = config.theme.spacing.s;
          icon-size = 14;
          cursor = 60;
        };
      };
    };
    # font-family: "DepartureMono Nerd Font", monospace;
    style = ''
      * {
        border: none;
        border-radius: 0px;
        min-height: 0px;
      }

      window#waybar>box {
        padding: ${toString config.theme.spacing.s}px;
      }

      window#waybar {
        background-color: alpha(#${config.theme.colors.base00}, 0.5);
        color: #${config.theme.colors.base05};
        font-family: "DepartureMono Nerd Font", monospace;
      }

      tooltip {
        border-radius: ${toString config.theme.borderRadius}px;
        background-color: #${config.theme.colors.base01};
      }

      tooltip label {
        color: #${config.theme.colors.base05};
      }

      #workspaces button {
        all: unset;
        padding: 0px ${toString config.theme.spacing.s}px;
        background-color: transparent;
        color: #${config.theme.colors.base05};
      }

      #workspaces button.active {
        background-color: transparent;
        color: #${config.theme.colors.base08};
      }

      #workspaces button.urgent {
        background-color: transparent;
        color: #${config.theme.colors.base08};
      }

      #tray * {
        font-family: "Inter", monospace;
        border-radius: ${toString config.theme.borderRadius}px;
      }

      #clock {
        padding: 0px;
      }
    '';
  };
}
