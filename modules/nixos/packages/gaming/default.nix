{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.packages.gaming;
in {
  options.megadots.nixos.packages.gaming = {
    enable = mkEnableOption "Enable gaming features.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gamemode
      gamescope
      lutris
      mangohud
      steam
    ];

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
  };
}
