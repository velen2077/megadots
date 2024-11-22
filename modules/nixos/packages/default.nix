{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.packages;
in {
  options.megadots.packages = {
    enable = mkEnableOption "Enable packages to be included.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Common system packages that should be included
      # on all my systems.
      age
      bat
      brightnessctl
      btop
      curl
      eza
      fastfetch
      fd
      ffmpeg
      fzf
      git
      glow
      gnupg
      jq
      libnotify
      nh
      nix-index
      nix-output-monitor
      nurl
      obsidian
      pandoc
      rclone
      ripgrep
      signal-desktop
      sops
      spicetify-cli
      spotify
      ssh-to-age
      tree
      unzip
      vim
      vesktop
      wget
      # Devlopment packages, primarily used for
      # tools to assist in dev work.
      alejandra
      gcc
      gnumake
      gdb
      cmake
      just
      man-pages
      man-pages-posix
    ];
  };
}
