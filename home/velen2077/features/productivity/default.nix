{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./filen-desktop.nix
    ./firefox.nix
    ./obsidian.nix
    ./syncthing.nix
  ];
}
