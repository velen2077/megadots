# This file defines the "non-hardware dependent" part of opt-in persistence
# It imports impermanence, defines the basic persisted dirs, and ensures each
# users' home persist dir exists and has the right permissions.
#
# It works even if / is tmpfs, btrfs snapshot, or even not ephemeral at all.
{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      [
        "/var/log"
        "/etc/NetworkManager/system-connections"
        "/etc/nixos"
        "/etc/wireguard"

        "/var/cache/tuigreet" # Persist tuigreet sessions
        "/var/db/sudo/lectured" # Remember lectured sudo users
        "/var/lib/nixos"
        "/var/lib/sbctl"
        # "/var/lib/docker" # handled by ext4 fs mount for docker from /btr_pool/@dumps/docker-volume.img
        "/var/lib/alsa"
        "/var/lib/systemd"

        # Systemd requires /usr dir to be populated
        # See: https://github.com/nix-community/impermanence/issues/253
        "/usr/systemd-placeholder"
      ]
      ++ lib.optionals config.services.udisks2.enable ["/var/lib/udisks2"]
      ++ lib.optionals config.services.upower.enable ["/var/lib/upower"];
    files = [
      # The machine-id is a unique identifier for the system, generated
      # during installation. Persisting it is crucial for services like
      # systemd's journal to function correctly across reboots.
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
