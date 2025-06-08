{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };

  programs.gamemode.enable = true;

  services.udev.packages = [pkgs.sunshine];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      47984
      47989
      47990
      48010
    ];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
  };

  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    game-devices-udev-rules
  ];
}
