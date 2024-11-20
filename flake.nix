{
  description = "megadots by velen2077.";

  nixConfig = {
    extra-substituters = [
      #"https://cache.m7.rs"
      "https://chaotic-nyx.cachix.org/"
      #"https://nix-community.cachix.org"
      #"https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      #"cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      #"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    # Nix ecosystem.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Common hardware.
    hardware.url = "github:nixos/nixos-hardware";

    # Chaotic inputs for CachyOS and Zen kernels.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Nix color scheming.
    nix-colors.url = "github:misterio77/nix-colors";

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

    # Firefox addons to support my Firefox module.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    chaotic,
    plasma-manager,
    ...
  }: {
    nixosConfigurations = {
      endgame = let
        username = "velen2077";
        hostname = "endgame";
        stateVersion = "25.05";
        specialArgs = {inherit inputs username hostname stateVersion;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";

          modules = [
            ./hosts/${hostname}/configuration.nix
            chaotic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    };
  };
}
