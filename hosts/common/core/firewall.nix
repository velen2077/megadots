{lib, ...}: {
  networking.firewall.enable = lib.mkForce true;
}
