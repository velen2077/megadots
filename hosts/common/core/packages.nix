{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Apps installed on all hosts go here.
  environment.systemPackages = with pkgs; [
    alejandra # A code formatter for nix.
    btop # Resource monitor with graphs.
    cava # Audio visualizer.
    easyeffects # Pipewire equalizer.
    fastfetch # System information tool.
    fd # Fast alternative to 'find'.
    fzf # Command-line fuzzy finder.
    glib # Low-level core library for GNOME.
    jq # Command-line JSON processor.
    just # A command runner for project-specific commands.
    libnotify # Notification library.
    libsForQt5.qtstyleplugin-kvantum # Qt-theme framework.
    lm_sensors # Hardware monitoring utilities.
    mangohud # Performance overlay for games.
    nvtopPackages.full # GPU process monitor.
    pciutils # PCI utilities for device inspection.
    ripgrep # Fast alternative to grep.
    sbctl # Secure Boot utils.
    swtpm # Software-based TPM emulator for vm's.
    unzip # Zip file extraction utility.
  ];

  fonts.packages = with pkgs;
    [
      dejavu_fonts
      fira-code
      hack-font
      ibm-plex
      inconsolata
      jetbrains-mono
      liberation_ttf
      noto-fonts
      roboto
      roboto-mono
      source-code-pro
      ttf_bitstream_vera
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
