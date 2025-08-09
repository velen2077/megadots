{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.lanzaboote.nixosModules.lanzaboote
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
}
