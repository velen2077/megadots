{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.thermald;
in {
  options.megadots.thermald = {
    enable = mkEnableOption "Enable thermald service.";
  };

  config = mkIf cfg.enable {
    # thermald is a thermal monitor serivce that
    # helps prevent CPU's from overheating.
    services.thermald.enable = true;
  };
}
