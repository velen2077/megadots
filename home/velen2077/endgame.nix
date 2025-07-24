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
    # I apply to all my Home Manager users.
    ./common/core
    # Optional configs to import for this user.
    ./common/opttional/alacritty.nix
    ./common/opttional/code-cursor.nix
    ./common/opttional/digikam.nix
    ./common/opttional/element-desktop.nix
    ./common/opttional/filen-desktop.nix
    ./common/opttional/firefox.nix
    ./common/opttional/gnome.nix
    ./common/opttional/hugo.nix
    ./common/opttional/obsidian.nix
    ./common/opttional/signal-desktop.nix
    ./common/opttional/spicetify.nix
    ./common/opttional/syncthing.nix
    ./common/opttional/terraform.nix
    ./common/opttional/vesktop.nix
    ./common/opttional/vscodium.nix
    # Import my theme.
    ./common/themes/nord.nix
  ];

  monitors = [
    {
      name = "DP-2";
      make = "AUS";
      model = "VG27A";
      serial = "LALMQS176787";
      width = 2560;
      height = 1440;
      refreshRate = "143.972";
      workspace = "1";
      primary = true;
    }
  ];
}
