{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./hypridle/hypridle.nix
    ./hyprlock/hyprlock.nix
    ./hyprpaper/hyprpaper.nix
    ./mako/mako.nix
    ./rofi/rofi.nix
    ./scripts/scripts.nix
    ./waybar/waybar.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      jaq
    ];
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
