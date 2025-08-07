# This file (and the global directory) holds config that i use on all hosts
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
    alejandra
    fastfetch
    git
    just
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
