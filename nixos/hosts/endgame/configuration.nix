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
    ./disks.nix
    ./hardware-configuration.nix
    # Import my nixos host configs. Both core and optional.
    # Optionals are enabled on a per config basis using the
    # megadots options. This includes user configs.
    ../../config
  ];

  megadots = {
    optional = {
      bluetooth.enable = true;
      cachyos.enable = true;
      cosmic.enable = true;
      gnome.enable = false;
      pipewire.enable = true;
    };
    users = {
      velen2077.enable = true;
    };
  };

  # Set the host-specific hostname here.
  networking = {
    hostName = "endgame";
  };

  # Set the hosts system state version.
  system.stateVersion = "24.11";
}
