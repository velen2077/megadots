{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.kernel.cachy;
in {
  #imports = [inputs.chaotic.nixosModules.default];
  options.megadots.kernel.cachy = {
    enable = mkEnableOption "Enable CachyOS kernel.";
  };
  config = mkIf cfg.enable {
    #chaotic.nyx.overlay.enable = true;
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
    boot.kernelParams = ["quiet"];
  };
}
