{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.packages.development;
in {
  options.megadots.packages.development = {
    enable = mkEnableOption "Enable development packages.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixd # Nix LSP
      alejandra # Nix formatter
      just
      nixfmt-rfc-style
      nvd # Differ
      nix-diff # Differ, more detailed
      nix-output-monitor
      nh # Nice wrapper for NixOS and HM
    ];
  };
}
