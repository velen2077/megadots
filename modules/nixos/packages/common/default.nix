{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.packages.common;
in {
  options.megadots.nixos.packages.common = with types; {
    enable = mkEnableOption "Whether to enable common packages.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
      btop
      eza
      fastfetch
      git
      gnupg
      home-manager
      jq
      libnotify
      nh
      nix-index
      nix-output-monitor
      nurl
      rclone
      ripgrep
      sops
      ssh-to-age
      tree
      unzip
      vim
    ];
  };
}
