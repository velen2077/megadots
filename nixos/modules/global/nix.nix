{inputs, ...}: {
  imports = [
    inputs.chaotic.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
  ];
  # Mark admins as trusted users.
  nix.settings.trusted-users = [
    "@wheel"
  ];
}
