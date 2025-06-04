{
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users.
    ../modules/global
    # Optional configs to import for this user.
    ../modules/optional/gnome.nix
    ../modules/optional/persistence.nix
    #../modules/optional/steam.nix
  ];
}
