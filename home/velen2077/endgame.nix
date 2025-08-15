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
    ./features/theme
    # Import my desktop/window manager/compositor.
    ./features/desktop/gnome
  ];

  monitors = [
    {
      enabled = true;
      name = "HDMI-A-1";
      make = "AUS";
      model = "VG27A";
      serial = "LALMQS176787";
      width = 2560;
      height = 1440;
      refreshRate = 143.972;
      scale = 1.00;
      workspace = "1";
      primary = true;
    }
  ];
}
