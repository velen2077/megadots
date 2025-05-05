{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.optional.systemd-boot;
in {
  options.megadots.optional.systemd-boot = {
    enable = mkEnableOption "Enable systemd-boot.";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          consoleMode = "max";
        };
        efi.canTouchEfiVariables = true;
        timeout = 30;
      };
    };
  };
}
