{
  config,
  inputs,
  outputs,
  lib,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.chaotic.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.impermanence.nixosModules.impermanence
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      extra-substituters = [
        "https://chaotic-nyx.cachix.org/"
      ];
      extra-trusted-public-keys = [
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
      trusted-users = [
        "@wheel"
      ];
      auto-optimise-store = true;
      allow-import-from-derivation = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      flake-registry = ""; # Disable global flake registry
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Keep the last 3 generations
      options = "--delete-older-than +10";
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = ".bak";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  hardware.enableRedistributableFirmware = true;

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
    virtualisation.qemu.options = [
      "-vga qxl"
    ];
  };
}
