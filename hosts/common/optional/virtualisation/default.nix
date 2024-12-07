{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.virtualisation;
in {
  options.modules.virtualisation = with types; {
    enable = mkEnableOption "Enable virtualisation settings.";
  };

  config = mkIf cfg.enable {
    virtualisation.vmVariant = {
      virtualisation = {
        memorySize = 8192;
        cores = 4;
      };
    };
  };
}
