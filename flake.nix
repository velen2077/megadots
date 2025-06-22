{
  # For those who come after.
  description = "megadots - a NixOS and Home Manager configuration repo by velen2077.";

  # Extra substitutors and keys for any input in my config
  # that needs one. Chaotic is a good example.
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
    # Sylix for theming.
    stylix.url = "github:nix-community/stylix";
    # Firefox addons to support my Firefox
    # Home Manager module. These allow installation
    # of Firefox Extensions such as uBlock Origin.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Spicetify customised Spotify client.
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for my flake packages, shell, etc. Included in
    # the Systems input and includes updated NixOS supported systems.
    lib = nixpkgs.lib // home-manager.lib;
    myLib = import ../lib {
      inherit lib;
      inherit (builtins) builtins;
    };
    forAllSystems = nixpkgs.lib.genAttrs [
      # I'm only using x86_64-linux at the moment but if that changes
      # I'll need to add additional system architectures here.
      "x86_64-linux"
    ];
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
    packages = forAllSystems (pkgs: import ./pkgs {inherit pkgs;});
    # Formatter for my nix files, available through 'nix fmt'.
    # Other options beside 'alejandra' include 'nixpkgs-fmt'.
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    # Dev shell for working on my config.
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = [
          pkgs.alejandra
          pkgs.git
        ];
      };
    });
    # NixOS configuration entrypoint. These are available
    # through 'nixos-rebuild --flake .#hostname'.
    nixosConfigurations = {
      # NixOS configuration for my host 'endgame'. My primary
      # desktop computer, running NixOS.
      endgame = lib.nixosSystem {
        # The 'specialArgs' attribute allows you to pass extra arguments
        # to all modules in this configuration. This is a convenient way
        # to make your flake inputs (like `inputs` and `outputs`) available
        # to your NixOS modules.
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Import the primary configuration file for host.
          ./nixos/hosts/endgame/configuration.nix
        ];
      };
      # NixOS configuration for my host 'flatmate'. My primary
      # laptop computer (Surface Pro 7), running NixOS.
      flatmate = lib.nixosSystem {
        # The 'specialArgs' attribute allows you to pass extra arguments
        # to all modules in this configuration. This is a convenient way
        # to make your flake inputs (like `inputs` and `outputs`) available
        # to your NixOS modules.
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Import the primary configuration file for host.
          ./nixos/hosts/flatmate/configuration.nix
        ];
      };
      # NixOS vm for testing my configs.
      nixvm = lib.nixosSystem {
        # The 'specialArgs' attribute allows you to pass extra arguments
        # to all modules in this configuration. This is a convenient way
        # to make your flake inputs (like `inputs` and `outputs`) available
        # to your NixOS modules.
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Import the primary configuration file for host.
          ./nixos/hosts/nixvm/configuration.nix
        ];
      };
    };
  };
}
