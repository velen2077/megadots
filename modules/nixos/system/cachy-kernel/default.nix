{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.system.cachy-kernel;
in {
  options.megadots.nixos.system.cachy-kernel = with types; {
    enable = mkEnableOption "Whether to enable the cachy kernel.";
  };

  config = mkIf cfg.enable {
    chaotic.nyx.overlay.enable = true;
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
  };
}
