{pkgs, ...}: {
  # List the packages that are to be installed on
  # all of my NixOS systems. When adding a new
  # package, I decide:
  # All NixOS systems, system-installed? Add here.
  # Single specific NixOS system? Add to configuration.nix.
  environment.systemPackages = with pkgs; [
    age
    alejandra
    fastfetch
    game-devices-udev-rules
    git
    just
    sops
  ];
}
