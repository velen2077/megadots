{
  lib,
  osConfig,
  ...
}: {
  imports =
    [
      ./alacritty
      ./firefox
      ./vscodium
      ./zsh
    ]
    ++ (lib.optionals (osConfig.megadots.nixos.optional.kde.enable) [./kde]);
}
