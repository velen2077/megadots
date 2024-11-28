{
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    #overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # Specify NixOS specific settings for things like
  # automatic garbage collection.
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = lib.mkDefault true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Keep the last 10 generations.
      options = "--delete-older-than +10";
    };
  };
}
