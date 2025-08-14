{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users and all sit within
    # the cli subfolder..
    ./global
    # Import my features for the user on this host. This can
    # either be the folder itself (all contents imported via
    # the included default.nix) or individual nix files wihin
    # each feature subfolder if I want to be selective.
    ./features/comms
    ./features/development
    ./features/gaming
    ./features/media
    ./features/productivity
    # Import my desktop/window manager/compositor.
    ./features/desktop/gnome
  ];

  theme = {
    wallpaper = ../../assets/wallpaper/overwatch.jpg;

    # Stylix configuration.
    stylix = {
      enable = true;
      base16Scheme = "rose-pine";
      polarity = "dark";
      disableTargets = ["hyprland" "hyprlock" "rofi"];
      firefoxProfiles = ["default"];
    };

    # GTK configuration.
    gtk = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    # QT configuration.
    qt = {
      enable = true;
    };

    # Cursor configuration.
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 22;
    };
  };

  # User specific theme fixes that don't need to
  # be a part of my theme module.
  stylix.targets.waybar.addCss = false;

  monitors = [
    {
      enabled = true;
      name = "HDMI-A-2";
      make = "AUS";
      model = "VG27A";
      serial = "LALMQS176787";
      width = 2560;
      height = 1440;
      refreshRate = 144.01;
      scale = 1.00;
      workspace = "1";
      primary = true;
    }
  ];
}
