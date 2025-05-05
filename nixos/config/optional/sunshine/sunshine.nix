{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.sunshine;
in {
  options.megadots.optional.sunshine = {
    enable = mkEnableOption "Enable sunshine.";
  };

  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      package = pkgs.sunshine;
      openFirewall = true;
      capSysAdmin = true;
      applications = {
        apps = [
          {
            name = "Desktop";
          }
          {
            name = "Steam Big Picture";
            output = "/tmp/sunlight-steam.txt";
            detached = ["${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/bigpicture"];
          }
        ];
      };
    };

    # Required to simulate input in sunshine.
    services.udev.extraRules = lib.optionalString config.services.sunshine.enable ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
  };
}
