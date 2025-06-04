{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.chaotic.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
  ];
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
