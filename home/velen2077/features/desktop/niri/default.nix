{
  inputs,
  pkgs,
  ...
}:
# Wayland config
{
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    #grim
    #slurp
    #seatd
    #jaq
    #swww
    # utils
    #wl-clipboard
    #brightnessctl
    #pavucontrol
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
