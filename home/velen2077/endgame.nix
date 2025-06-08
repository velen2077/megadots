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
    ./optional/digikam.nix
    ./optional/filen-desktop.nix
    ./optional/firefox.nix
    ./optional/gnome.nix
    ./optional/signal-desktop.nix
    ./optional/vesktop.nix
    ./optional/vscodium.nix
  ];
}
