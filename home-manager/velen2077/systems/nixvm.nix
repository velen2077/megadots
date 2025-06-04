{
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users.
    ../modules/global
    # Optional configs to import for this user.
    ../modules/optional/alacritty.nix
    ../modules/optional/filen-desktop.nix
    ../modules/optional/firefox.nix
    ../modules/optional/gnome.nix
    ../modules/optional/persistence.nix
    ../modules/optional/signal-desktop.nix
    ../modules/optional/vesktop.nix
    ../modules/optional/vscodium.nix
    #../modules/optional/steam.nix
  ];
}
