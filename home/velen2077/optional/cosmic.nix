# This is a placeholder for COSMIC Desktop Environment settings
# managed by Home Manager.
#
# The nixos-cosmic flake does not currently provide a Home Manager
# module, but this file is ready for when it does.
{...}: {
  # You could add user packages or theme files here in the future.
  home.persistence."/persist" = {
    directories = [
      ".config/cosmic"
      ".local/state/cosmic"
      ".local/state/cosmic-comp"
      ".local/state/pop-launcher"
    ];
    files = [
    ];
  };
}
