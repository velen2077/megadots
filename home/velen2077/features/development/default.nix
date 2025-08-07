{pkgs, ...}: {
  imports = [
    ./code-cursor.nix
    ./hugo.nix
    ./terraform.nix
    ./vscodium.nix
  ];
}
