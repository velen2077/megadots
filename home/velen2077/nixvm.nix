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
    ./common/optional/alacritty.nix
    ./common/optional/code-cursor.nix
    #./optional/cosmic.nix
    ./common/optional/firefox.nix
    ./common/optional/gnome.nix
    ./common/optional/obsidian.nix
    ./common/optional/spicetify.nix
    ./common/optional/terraform.nix
    ./common/optional/vscodium.nix
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
