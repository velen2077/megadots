{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.steam;
in {
  options.megadots.optional.steam = {
    enable = mkEnableOption "Enable steam.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gamescope
      mangohud
    ];

    programs = {
      gamescope = {
        args = ["--rt"];
        capSysNice = true;
      };

      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        gamescopeSession = {
          enable = true;
          args = [
            "--fsr-sharpness 10"
            "-U"
            "--adaptive-sync"
          ];
        };
      };
    };
  };
}
