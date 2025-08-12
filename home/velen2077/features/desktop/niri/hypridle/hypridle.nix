{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enabling hypridle to handle idle-related actions like screen locking.
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        # This is the command I want to run when the system is idle
        # for a certain period — in this case, it locks the screen.
        lock_cmd = "pidof hyprlock || hyprlock";
        # Setting this to false so that applications (like video players)
        # that ask to inhibit idle actions are respected.
        ignore_dbus_inhibit = false;
      };
      # Define what should happen after a period of inactivity.
      listener = [
        {
          # Trigger after 900 seconds (15 minutes) of no user input.
          timeout = 900;
          # When the timeout is reached, lock the screen using hyprlock.
          on-timeout = "hyprlock";
          # Not using on-resume here, but it could be added if needed.
        }
      ];
    };
  };

  #systemd.user.services.hypridle = lib.mkForce {}; # Disable hypridle systemd service
}
