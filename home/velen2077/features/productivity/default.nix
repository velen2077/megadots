{pkgs, ...}: {
  imports = [
    ./filen-desktop.nix
    ./firefox.nix
    ./obsidian.nix
    ./syncthing.nix
  ];
}
