{
  description = "megadots by velen2077.";

  nixConfig = {
    extra-substituters = [
      "https://chaotic-nyx.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };

  inputs = {
    # Nixpkgs. By default, I'm using unstable. This can be overuled
    # on a per-package basis using the stable-packages overlay.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # Common system definition input.
    systems.url = "github:nix-systems/default-linux";
    # Common hardware input.
    hardware.url = "github:nixos/nixos-hardware";
    # Impermanence for nixos.
    impermanence.url = "github:nix-community/impermanence/home-manager-v2";
    # Home Manager for managing my dotfiles and user config.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Chaotic inputs for CachyOS and Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # Disko disk partitioning.
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Sylix.
    stylix.url = "github:nix-community/stylix";
    # Firefox addons to support my Firefox
    # Home Manager module. These allow installation
    # of Firefox Extensions such as uBlock Origin.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    chaotic,
    disko,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for my flake packages, shell, etc. Included in
    # the Systems input and includes updated NixOS supported systems.
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          # Allows the use of non-free software.
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    # Import my nixos modules. These modules should not be confused with
    # nixos configuration files. These are typically custom modules that
    # I may want to share in the future.
    nixosModules = import ./modules/nixos;
    # Same goes with home-manager modules. This is not my per user configs
    # but custom modules with options I may wish to share.
    homeManagerModules = import ./modules/home-manager;
    # Import my custom packages and modifications, exported as overlays.
    overlays = import ./overlays {inherit inputs outputs;};
    # My custom packages accessible through 'nix build', 'nix shell', etc.
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Formatter for my nix files, available through 'nix fmt'.
    # Other options beside 'alejandra' include 'nixpkgs-fmt'.
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    # NixOS configuration entrypoint. These are available
    # through 'nixos-rebuild --flake .#hostname'.
    nixosConfigurations = {
      # NixOS configuration for my host 'endgame'. My primary
      # desktop computer, running NixOS.
      endgame = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Import the primary configuration file for host.
          ./nixos/hosts/endgame/configuration.nix
        ];
      };
      # NixOS configuration for my host 'flatmate'. My primary
      # laptop computer (Surface Pro 7), running NixOS.
      flatmate = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Import the primary configuration file for host.
          ./nixos/hosts/flatmate/configuration.nix
        ];
      };
      # NixOS vm for testing my configs.
      nixvm = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Import the primary configuration file for host.
          ./nixos/hosts/nixvm/configuration.nix
        ];
      };
    };
  };
}
# These systems run on logic, code, and care,
# But tucked within its config, there's something rare.
#
# To Edie, Maisey, and Logan — my stars, my song,
# This world moves fast, but my love is strong.
#
# In bits and bytes these systems may grow,
# Yet what truly matters is what you sow,
# Kindness, courage, and being true,
# The best parts of me live on in you.
#
# If someday you find this, nestled in code,
# Know that wherever you are, or go, or grow old,
# Your names are written in every line,
# May it remind you: you are my home.

