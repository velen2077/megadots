{
  config,
  lib,
  ...
}: {
  # The below persistence settings should be applied to
  # all of my NixOS systems. If there are system-specific
  # persistence settings required, add them to the
  # specific module requiring them, or to the system
  # configuration.nix.
  environment.persistence."/persist" = {
    # hideMounts stops the volumes being shown in file
    # managers and is generally preferred.
    hideMounts = true;
    # Directories I want to persist.
    directories = [
      "/var/lib/systemd"
      "/var/lib/nixos"
      "/var/log"
      "/etc/NetworkManager/system-connections"
    ];
    # File I want to persist.
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
