{
  imports = [
    # Import all core Home Manager modules to apply them
    # all automatically for the user on this system.
    ./common/core
    # Import all optional Home Manager modules. These are
    # then applied using the 'megadots.home.optional.<feature>
    # flags to toggle them on or off and supply values if needed.
    ./common/optional
  ];

  # Here is where the fun happens. All the modules should
  # be loaded through imports, and they can be toggled on or
  # off using the appropriate megadots option.
  megadots.home.optional = {
    alacritty.enable = true;
    firefox.enable = true;
    vscodium.enable = true;
    zsh.enable = true;
  };
}
