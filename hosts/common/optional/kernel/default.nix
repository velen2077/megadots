{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.optional.kernel.cachy;
in {
  options.megadots.nixos.optional.kernel.cachy = {
    enable = mkEnableOption "Enable CachyOS kernel.";
  };
  config = mkIf cfg.enable {
    chaotic.nyx.overlay.enable = true;
    chaotic.scx = {
      enable = true;
      package = pkgs.scx_git.lavd;
      scheduler = "scx_lavd";
    };
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
    #boot.kernelParams = ["quiet"];
  };
}
