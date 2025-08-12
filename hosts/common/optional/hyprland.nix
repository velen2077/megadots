{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
        };
      };
    };

    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
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

  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MANGOHUD = "1"; # for mangohud
  };
}
