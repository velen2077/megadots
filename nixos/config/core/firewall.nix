{
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;

    allowedUDPPorts = [
      # Tailscale direct connection.
      3478
      41641
    ];

    allowedTCPPorts = [
      # SSH.
      22
    ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 9000;
      }
    ];
  };
}
