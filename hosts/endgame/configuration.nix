{
  inputs,
  outputs,
  ...
}: {
  # Import needed modules here. This is going to pull in my hardware-configuration,
  # global configs (stuff shared between all hosts), optional configs, and
  # my user configs for any users I want added to this host.
  imports = [
    # Import the specific hardware-configuration.nix for this host.
    ./hardware-configuration.nix
    # Import my global configs.
    ../config/global
    # Import optional configs for this host.
    ../config/optional/audio
    ../config/optional/bluetooth
    ../config/optional/cachyos
    ../config/optional/gnome
    #../config/optional/theme
    # Import required users for this host.
    ../config/users/velen2077
  ];

  # Set the host-specific hostname here.
  networking = {
    hostName = "endgame";
  };

  # Enable adb and dconf for the host.
  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  # Enable graphics.
  hardware.graphics.enable = true;

  # Set the hosts system state version.
  system.stateVersion = "24.11";
}
