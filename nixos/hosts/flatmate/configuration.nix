{
  inputs,
  outputs,
  ...
}: {
  # Import needed modules here. This is going to pull in my hardware-configuration,
  # global configs (stuff shared between all hosts), optional configs, and
  # my user configs for any users I want added to this host.
  imports = [
    # Import the relevant common hardware modules from the hardware flake
    # for this specific host.
    inputs.hardware.nixosModules.microsoft-surface-pro-intel
    # Import the specific hardware-configuration.nix for this host.
    ./disks.nix
    ./hardware-configuration.nix
    # Import my nixos host configs. Both core and optional.
    # Optionals are enabled on a per config basis using the
    # megadots options. This includes user configs.
    ../../config
  ];

  # The megadots options are where optional configurations are
  # applied to this host. I try to keep every option listed,
  # and use enable = true; to turn on what I need.
  megadots = {
    # Optional configurations to enable for this host.
    optional = {
      bluetooth.enable = true;
      cachyos.enable = true;
      cosmic.enable = true;
      gnome.enable = false;
      pipewire.enable = true;
    };
    # Optional users to enable for this host.
    users = {
      velen2077.enable = true;
    };
  };

  # Set the host-specific hostname here.
  networking = {
    hostName = "flatmate";
  };

  # Set the hosts system state version.
  system.stateVersion = "24.11";
}
