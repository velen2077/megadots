# This file (and the global directory) holds config that i use on all hosts
{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  # Nixpkgs config.
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    settings = {
      extra-substituters = [
        "https://niri.cachix.org/"
      ];
      extra-trusted-public-keys = [
        "niri.cachix.org-1:P72D+G6LgqKj7e9xYnL0M125bV7D57T9zYJ5K24Jq4I="
      ];
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [
        "root"
        "@wheel"
      ];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      warn-dirty = false;
      # Allow importing derivations from derivations.
      allow-import-from-derivation = true;
      # Enable experimental features.
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Delete generations that haven't been activated in
      # over 30 days.
      options = "--delete-older-than 30d";
    };
  };

  # nix-ld provides a shim for ELF binaries to automatically find their
  # shared library dependencies in the Nix store. This is essential for
  # running pre-compiled binaries that are not packaged in Nixpkgs.
  programs.nix-ld = {
    enable = true;
  };
}
