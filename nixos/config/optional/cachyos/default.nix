{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.cachyos;
in {
  options.megadots.optional.cachyos = {
    enable = mkEnableOption "Enable cachyos kernel.";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
    boot.kernelParams = ["quiet"];
  };
}
