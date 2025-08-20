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
    ./features/services
    # Import my desktop/window manager/compositor.
    ./features/desktop/cosmic
  ];

  theme = {
    # The wallpaper for the user.
    wallpaper = ../../assets/wallpaper/overwatch.jpg;
    borderWidth = 4;

    # Stylix configuration.
    stylix = {
      enable = true;
      base16Scheme = "rose-pine";
      polarity = "dark";
      disableTargets = [];
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

  monitors = [
    {
      enabled = true;
      name = "Virtual-1";
      make = "Red Hat, Inc.";
      model = "QEMU Monitor";
      serial = "VM";
      width = 1920;
      height = 1080;
      refreshRate = 60.000;
      scale = 1.00;
      workspace = "1";
      primary = true;
    }
  ];
}
