{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.cachyos;
in {
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  options.megadots.cachyos = {
    enable = mkEnableOption "the foo program";
  };

  config = mkIf cfg.enable {
    # Use the latest CachyOS kernel which is better optimised
    # for gaming workloads.
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
  };
}
