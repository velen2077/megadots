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
      };
      system = {
        impermanence.enable = true;
      };
      zsh.enable = true;
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    signal-desktop
    telegram-desktop
  ];
}
