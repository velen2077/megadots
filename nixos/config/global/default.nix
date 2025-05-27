# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  lib,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./fish.nix
      ./gamemode.nix
      ./locale.nix
      ./nix-ld.nix
      ./nix.nix
      ./openssh.nix
      ./persistence.nix
      ./steam-hardware.nix
      ./systemd-initrd.nix
      ./thermald.nix
      ./upower.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
  networking.domain = "extranet.casa";

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  # Cleanup stuff included by default
  services.speechd.enable = lib.mkDefault false;
}
