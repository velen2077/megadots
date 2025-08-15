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
    easyeffects # Pipewire equalizer.
    fastfetch # System information tool.
    fd # Fast alternative to 'find'.
    fzf # Command-line fuzzy finder.
    jq # Command-line JSON processor.
    just # A command runner for project-specific commands.
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
