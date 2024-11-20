{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.cachyKernel;
in {
  #imports = [inputs.chaotic.nixosModules.default];
  options.megadots.cachyKernel = {
    enable = mkEnableOption "Enable CachyOS kernel.";
  };
  config = mkIf cfg.enable {
    #chaotic.nyx.overlay.enable = true;
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
    boot.kernelParams = ["quiet"];
  };
}
