{...}: {
  imports = [
    # Import my core nixos confifuration. These are configurations
    # that are required on all nixos hosts I build and are not
    # controlled by mkOptions (megadots).
    ./core/firewall.nix
    ./core/fish.nix
    ./core/locale.nix
    ./core/nix.nix
    ./core/packages.nix
    ./core/system.nix
    ./core/systemd-boot.nix
    # Import any optional configurations. These may not be required
    # on all hosts I build and can be enabled in the hosts
    # configuration.nix by using the megadots options.
    ./optional/bluetooth.nix
    ./optional/cachyos.nix
    ./optional/cosmic.nix
    ./optional/gnome.nix
    ./optional/pipewire.nix
    # Import my users. These are optional, and like optional
    # configurations above, can be enabled per-host using the
    # megadots option for each user.
    ./users/velen2077
  ];
}
