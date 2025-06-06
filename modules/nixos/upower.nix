{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.upower;
in {
  options.megadots.upower = {
    enable = mkEnableOption "Enable upower service.";
  };

  config = mkIf cfg.enable {
    # Enable upower, a DBus service that provides
    # power management support to applications.
    services.upower.enable = true;
  };
}
