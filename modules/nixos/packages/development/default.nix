{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.packages.development;
in {
  options.megadots.nixos.packages.development = with types; {
    enable = mkEnableOption "Whether to enable development packages.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscodium
    ];
  };
}
