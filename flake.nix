{
  description = "megadots - a NixOS and Home Manager configuration repo by velen2077.";

  # Configure Nix to use additional binary caches and their public keys.
  # This speeds up builds by allowing Nix to download pre-built packages
  # from these caches.
  nixConfig = {
    extra-substituters = [
      "https://chaotic-nyx.cachix.org/"
      "https://cosmic.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  # Define all the flake inputs (dependencies) for the configuration.
  inputs = {
    # Nixpkgs is the primary source of packages. It is set to the
    # unstable channel by default.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # A stable version of Nixpkgs for specific packages.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # Common hardware definitions for NixOS.
    hardware.url = "github:nixos/nixos-hardware";
    # A list of available Nix systems, such as x86_64-linux
    # and aarch64-linux.
    systems.url = "github:nix-systems/default-linux";
    # Manages impermanent file system configurations.
    impermanence.url = "github:nix-community/impermanence/home-manager-v2";
    # Home Manager is used to manage user-specific configurations
    # and dotfiles.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Secure Boot for NixOS.
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Chaotic provides a Nixpkgs overlay with additional packages,
    # often with CachyOS or Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # A Nix module for declarative disk partitioning.
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # A Nix module for system-wide theming.
    stylix.url = "github:nix-community/stylix";
    # Provides Firefox extensions as Nix packages.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # A Nix flake for customising the Spotify client with Spicetify.
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    # A flake for the COSMIC desktop environment.
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    lanzaboote,
    ...
  } @ inputs: let
    # Inherit outputs from the current flake.
    inherit (self) outputs;
    # Combine the Nixpkgs and Home Manager libraries for
    # unified function access.
    lib = nixpkgs.lib // home-manager.lib;
    # A helper function to apply a function across all
    # supported systems.
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    # A set of Nixpkgs packages for each supported system,
    # with unfree packages enabled.
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    # Expose custom NixOS modules for the configuration.
    nixosModules = import ./modules/nixos;
    # Expose custom Home Manager modules for user
    # configurations.
    homeManagerModules = import ./modules/home-manager;
    # Expose custom packages as overlays.
    overlays = import ./overlays {inherit inputs outputs;};
    # Build custom packages from the local
    # `pkgs` directory.
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Specify the Nix file formatter to be used
    # by `nix fmt`.
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    # Define a development shell with specific tools
    # for working on the flake, such as `alejandra`
    # for formatting and `git` for version control.
    devShells = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = [
          # Packages to include in devShell.
          pkgs.alejandra
          pkgs.git
        ];
      };
    });
    # Define system configurations for each host.
    nixosConfigurations = {
      # The configuration for the primary desktop
      # computer, named 'endgame'.
      endgame = lib.nixosSystem {
        modules = [
          ./hosts/nixos/endgame/configuration.nix
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      # The configuration for a virtual machine
      # used for testing, named 'nixvm'.
      nixvm = lib.nixosSystem {
        modules = [
          ./hosts/nixos/nixvm/configuration.nix
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
