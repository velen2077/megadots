{...}: {
  imports = [
    # Import my core nixos confifuration. These are configurations
    # that are required on all nixos hosts I build and are not
    # controlled by mkOptions (megadots).
    ./core/firewall
    ./core/fish
    ./core/locale
    ./core/nix
    ./core/packages
    ./core/ssh
    ./core/system
    ./core/systemd-boot
    # Import any optional configurations. These may not be required
    # on all hosts I build and can be enabled in the hosts
    # configuration.nix by using the megadots options.
    ./optional/steam
    ./optional/bluetooth
    ./optional/cachyos
    ./optional/cosmic
    ./optional/gnome
    ./optional/impermanence
    ./optional/pipewire
    # Import my users. These are optional, and like optional
    # configurations above, can be enabled per-host using the
    # megadots option for each user.
    ./users/velen2077
  ];
}
