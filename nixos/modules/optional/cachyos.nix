{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Use the latest CachyOS kernel which is better optimised
  # for gaming workloads.
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
}
