{
  inputs,
  lib,
  outputs,
  ...
}: {
  imports =
    [
      #      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      #inputs.impermanence.nixosModules.impermanence
      #inputs.stylix.nixosModules.stylix
    ]
    ++ (builtins.attrValues outputs.nixosModules);
  nix = {
    settings = {
      trusted-users = [
        "@wheel"
      ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Delete generations that haven't been activated in
      # over 30 days.
      options = "--delete-older-than +30";
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  # Enable passwordless sudo for members
  # of wheel group.
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
}
