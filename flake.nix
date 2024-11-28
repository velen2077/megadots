{
  description = "megadots by velen2077.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Chaotic inputs for CachyOS and Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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

      # Add overlays for the `nixpkgs` channel.
      overlays = with inputs; [
        inputs.chaotic.overlays.default
      ];

      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        chaotic.nixosModules.default
      ];
    };
}
