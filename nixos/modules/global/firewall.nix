{lib, ...}: {
  # Enable the firewall by default and allow
  # SSH traffic on port tcp22.
  networking.firewall = {
    enable = lib.mkForce true;
    allowedTCPPorts = [22];
  };
}
