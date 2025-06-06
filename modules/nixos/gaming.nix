{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.gaming;
in {
  options.megadots.gaming = {
    enable = mkEnableOption "Enable gaming packages and optimisations.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    programs.gamemode.enable = true;

    services.sunshine = {
      enable = true;
      autoStart = false;
      package = pkgs.sunshine;
      openFirewall = true;
      capSysAdmin = true;
      settings = {
        sunshine_name = config.networking.hostName;
      };
      applications = {
        apps = [
          {
            name = "Steam Big Picture";
            output = "/tmp/sunlight-steam.txt";
            detached = ["${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/bigpicture"];
            image-path = "steam.png";
          }
        ];
      };
    };

    hardware.steam-hardware.enable = true;

    environment.systemPackages = with pkgs; [
      game-devices-udev-rules
    ];

    # Required to simulate input in sunshine.
    services.udev.extraRules = lib.optionalString config.services.sunshine.enable ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
  };
}
