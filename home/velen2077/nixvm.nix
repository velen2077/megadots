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
    ./global
    # Optional configs to import for this user.
    ./optional/alacritty.nix
    ./optional/firefox.nix
    ./optional/gnome.nix
    ./optional/vscodium.nix
  ];

  monitors = [
    {
      name = "Virtual-1";
      width = 1920;
      height = 1080;
      primary = true;
    }
  ];
}
