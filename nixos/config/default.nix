{...}: {
  imports = [
    # Import my core nixos confifuration. These are configurations
    # that are required on all nixos hosts I build and are not
    # controlled by mkOptions (megadots).
    ./core/firewall/firewall.nix
    ./core/fish/fish.nix
    ./core/locale/locale.nix
    ./core/nix/nix.nix
    ./core/packages/packages.nix
    ./core/ssh/ssh.nix
    ./core/system/system.nix
    ./core/systemd-boot/systemd-boot.nix
    # Import any optional configurations. These may not be required
    # on all hosts I build and can be enabled in the hosts
    # configuration.nix by using the megadots options.
    ./optional/bluetooth/bluetooth.nix
    ./optional/cachyos/cachyos.nix
    ./optional/cosmic/cosmic.nix
    ./optional/gnome/gnome.nix
    ./optional/gpu-screen-recorder/gpu-screen-recorder.nix
    ./optional/impermanence/impermanence.nix
    ./optional/pipewire/pipewire.nix
    ./optional/steam/steam.nix
    ./optional/sunshine/sunshine.nix
    # Import my users. These are optional, and like optional
    # configurations above, can be enabled per-host using the
    # megadots option for each user.
    ./users/velen2077
  ];
}
