{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./filen-desktop.nix
    ./firefox.nix
    ./nextcloud.nix
    ./obsidian.nix
    ./syncthing.nix
  ];
}
