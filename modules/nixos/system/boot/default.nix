{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.system.boot;
in {
  options.megadots.nixos.system.boot = with types; {
    enable = mkEnableOption "Whether to enable the boot settings.";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelParams = [
      "quiet"
    ];
  };
}
