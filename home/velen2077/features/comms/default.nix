{pkgs, ...}: {
  imports = [
    ./element-desktop.nix
    ./signal-desktop.nix
    ./vesktop.nix
  ];
}
