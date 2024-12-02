{
  description = "megadots by velen2077.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Impermanence module.
    impermanence.url = "github:nix-community/impermanence";

    # Disko disk partitioning.
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Common hardware.
    hardware.url = "github:nixos/nixos-hardware";

    # Chaotic inputs for CachyOS and Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Firefox addons to support my Firefox
    # Home Manager module. These allow installation
    # of Firefox Extensions such as uBlock Origin.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  # This is an example and in your actual flake you can use `snowfall-lib.mkFlake`
  # directly unless you explicitly need a feature of `lib`.
  let
    lib = inputs.snowfall-lib.mkLib {
      # You must pass in both your flake's inputs and the root directory of
      # your flake.
      inherit inputs;
      src = ./.;
    };
  in
    lib.mkFlake {
      # Optionally place all packages under a namespace when used in an overlay.
      # Instead of accessing packages with `pkgs.<name>`, your internal packages
      # will be available at `pkgs.<namespace>.<name>`.
      snowfall.namespace = "megadots";

      # The attribute set specified here will be passed directly to NixPkgs when
      # instantiating the package set.
      channels-config = {
        # Allow unfree packages.
        allowUnfree = true;
      };

      # Add overlays for the `nixpkgs` channel.
      overlays = with inputs; [
        inputs.chaotic.overlays.default
      ];

      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        chaotic.nixosModules.default
        disko.nixosModules.disko
      ];
    };
}
