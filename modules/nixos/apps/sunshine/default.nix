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
    services.sunshine = {
      package = pkgs.sunshine.override {
        boost = pkgs.boost185;
      };
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
