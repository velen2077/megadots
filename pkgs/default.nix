# Custom packages modules. You can compose these into your own configuration
# by using my flake's overlay, or consume them through NUR. You can also
# build these directly using 'nix build .#example'.
{pkgs ? import <nixpkgs> {}}: rec {
  # Examples below from Misterio77's repo.
  # cd-gitroot = pkgs.callPackage ./cd-gitroot { };
  # zhooks = pkgs.callPackage ./zhooks { };
  # zsh-term-title = pkgs.callPackage ./zsh-term-title { };
}
