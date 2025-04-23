{
  description = "megadots by velen2077.";

  inputs = {
    # Nixpkgs. By default, I'm using unstable. This can be overuled
    # on a per-package basis using the stable-packages overlay.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # Home Manager for managing my dotfiles and user config.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Chaotic inputs for CachyOS and Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    chaotic,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for my flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument.
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # My custom packages accessible through 'nix build',
    # 'nix shell', etc.
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for my nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'.
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    # My custom packages and modifications, exported as overlays.
    overlays = import ./overlays {inherit inputs outputs;};
    # Reusable nixos modules I might want to export
    # These are usually stuff I would upstream into nixpkgs.
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules I might want to export
    # These are usually stuff I would upstream into home-manager.
    homeManagerModules = import ./modules/home-manager;
    # NixOS configuration entrypoint.
    # Available through 'nixos-rebuild --flake .#hostname'.
    nixosConfigurations = {
      # NixOS configuration for the host 'endgame'. My primary
      # desktop computer, running NixOS.
      endgame = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/endgame/configuration.nix
        ];
      };
    };
  };
}
