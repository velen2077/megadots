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
}
