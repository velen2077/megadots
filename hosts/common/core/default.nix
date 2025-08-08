{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./firewall.nix
      ./fish.nix
      ./hardware.nix
      ./locale.nix
      ./nix.nix
      ./packages.nix
      ./persistence.nix
      ./security.nix
      ./ssh.nix
      ./systemd-initrd.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  # Home-manager config.
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  hardware.enableRedistributableFirmware = true;

  # Cleanup stuff included by default
  services.speechd.enable = false;
}
