{osConfig, ...}: {
  imports =
    [
      ./alacritty
      ./firefox
      ./git
      ./zsh
    ]
    ++ (lib.optionals (osConfig.megadots.gnome.enable) [./gnome]);
}
