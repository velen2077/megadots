{...}: {
  # Import all my nixos system module here. This is
  # so that I can toggle them on or off by controlling
  # the megadots.<module> option in my system configuration.nix.
  # For this to work, NixOS must import all the modules
  # first to understand the options I have configured.
  imports = [
    ./audio
    ./bluetooth
    ./gaming
    ./gnome
    ./kde
    ./kernel
    ./nvidia
    ./packages
  ];
}
