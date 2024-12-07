{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules;
in {
  options.modules = {
    enable = mkEnableOption "Enable module.";
  };

  config =
    mkIf cfg.enable {
    };
}
