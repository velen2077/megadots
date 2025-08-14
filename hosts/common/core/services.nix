{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Disabling speechd, the speech dispatcher daemon, as it's not
  # needed for most desktop use cases and can consume resources.
  services = {
    # thermald helps prevent CPU's from overheating.
    thermald.enable = true;
    upower.enable = true;
    # needed for GNOME services outside of GNOME Desktop
    # dbus.enable = true;
    #dbus.packages = with pkgs; [
    #  gcr
    #  gnome-settings-daemon
    #  libsecret
    #  seahorse
    #];

    # gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
  };
}
