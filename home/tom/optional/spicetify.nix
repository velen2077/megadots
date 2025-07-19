{
  pkgs,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  # Allow spotify to be installed as I don't have unfree enabled.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  # Import the flake's module for my host.
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  # Configure spicetify.
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
    ];
  };

  home.persistence."/persist" = {
    directories = [
      ".config/spotify"
    ];
    files = [
    ];
  };
}
