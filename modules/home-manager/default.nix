{
  config,
  lib,
  osConfig,
  ...
}: {
  # Import all of the Home Manager modules so they can be
  # enabled or disabled using options in the home.nix user
  # file per Home Manager user.
  imports =
    [
      ./alacritty
      ./firefox
      ./git
      ./zsh
    ]
    # The imports below are only for Home Manager modules that
    # should be imported if certain system criteria are met. For
    # example, if we import the GNOME Home Manager module and
    # applied desktop environment is KDE, things will break, so
    # we only import if the correct module option is enabled.
    ++ (lib.optionals (osConfig.megadots.gnome.enable) [./gnome]);
}
