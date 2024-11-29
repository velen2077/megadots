{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  megadots.home = {
    # Apps.
    apps = {
      alacritty.enable = true;
      firefox.enable = true;
      git = {
        enable = true;
        username = "velen2077";
        email = "velen2077@proton.me";
        key = "8F1B8CFF76C80581";
      };
      zsh.enable = true;
    };
  };
}
