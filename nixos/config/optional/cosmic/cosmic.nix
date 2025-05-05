{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.cosmic;
in {
  options.megadots.optional.cosmic = {
    enable = mkEnableOption "Enable cosmic.";
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
    };
  };
}
