{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Common system packages that should be included
    # on all my nixos systems.
    age
    alejandra
    fastfetch
    git
    just
  ];

  # Enable adb and dconf for the host.
  programs = {
    adb.enable = true;
    dconf.enable = true;
  };
}
