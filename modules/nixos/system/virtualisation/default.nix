{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.system.virtualisation;
in {
  options.megadots.nixos.system.virtualisation = with types; {
    enable = mkEnableOption "Whether to enable virtualisation settings.";
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
