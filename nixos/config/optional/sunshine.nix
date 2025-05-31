{
  config,
  lib,
  pkgs,
  ...
}: let
  hostname = config.networking.hostName;
in {
  environment.systemPackages = with pkgs; [
    pkgs.sunshine
  ];
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
    settings = {
      # file_apps = "/home/servius/.config/sunshine/apps.json";
      sunshine_name = "${hostname}";
    };
    applications = {
      # env = {PATH = "/run/current-system/sw/bin";};
      apps = [
        {
          name = "Steam Big Picture";
          icon = "steam";
          detached = ["setsid steam steam://open/gamepadui"];
          #detached = ["/run/wrappers/bin/sudo -u servius ${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/gamepadui"];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }
      ];
    };
  };

  # Prevents this error:
  # Fatal: You must run [sudo setcap cap_sys_admin+p $(readlink -f sunshine)] for KMS display capture to work!
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
  # Needed for network discovery
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  boot.kernelModules = ["uinput"];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}
