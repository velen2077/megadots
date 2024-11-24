{
  # Welcome to megadots by velen2077. Find out more at
  # https://github.com/velen2077/megadots
  description = "megadots by velen2077.";

  # Substituters currently used for Cachy kernel
  # so that it doesn't need to be compiled everytime.
  nixConfig = {
    extra-substituters = [
      "https://chaotic-nyx.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };

  # Inputs for my megadots configuration. These are used throughout
  # NixOS and Home Manager and are always evolving as I add more
  # functionality to my config.
  inputs = {
    # Nix ecosystem.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Common hardware.
    hardware.url = "github:nixos/nixos-hardware";
    # Chaotic inputs for CachyOS and Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # Nix color scheming.
    nix-colors.url = "github:misterio77/nix-colors";
    # Stylix, for global themeing.
    stylix.url = "github:danth/stylix";
    # Home Manager.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # KDE Plasma manager.
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # Secrets management with SOPS and Nix.
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    chaotic,
    stylix,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # Entry points for system configurations with
    # Home Manager loaded as a system module.
    nixosConfigurations = {
      # My primary system, endgame. Desktop with nvidia
      # graphics card.
      endgame = lib.nixosSystem {
        modules = [./hosts/endgame];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
