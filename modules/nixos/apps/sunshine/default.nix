{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.apps.sunshine;
in {
  options.megadots.nixos.apps.sunshine = {
    enable = mkEnableOption "Enable and customise sunshine.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 47984;
        to = 48010;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48010;
      }
    ];
    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };
    systemd.user.services.sunshine = {
      description = "Sunshine self-hosted game stream host for Moonlight";
      startLimitBurst = 5;
      startLimitIntervalSec = 500;
      serviceConfig = {
        ExecStart = "${config.security.wrapperDir}/sunshine";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
