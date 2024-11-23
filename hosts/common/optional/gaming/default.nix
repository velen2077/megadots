{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.optional.gaming;
in {
  options.megadots.nixos.optional.gaming = {
    enable = mkEnableOption "Enable gaming features.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gamemode
      gamescope
      lutris
      mangohud
      steam
      sunshine
    ];

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;

    services.sunshine = {
      enable = true;
      autoStart = true;
      # This is needed for Wayland sessions. It can be
      # omitted when using .Xorg.
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
