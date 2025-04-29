# This file (and the global directory) holds config that i use on all hosts
{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.chaotic.nixosModules.default
      inputs.disko.nixosModules.disko
      ./bootloader
      ./fish
      ./locale
      ./nix
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

  environment.systemPackages = with pkgs; [
    # Common system packages that should be included
    # on all my systems.
    age
    alejandra
    fastfetch
    git
    just
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
    virtualisation.qemu.options = [
      "-vga qxl"
    ];
  };

  hardware.enableRedistributableFirmware = true;

  # Cleanup stuff included by default
  #services.speechd.enable = mkForce false;
}
