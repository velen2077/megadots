{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.system.impermanence;
in {
  options.megadots.nixos.system.impermanence = with types; {
    enable = mkEnableOption "Whether to enable impermanence.";
  };

  config = mkIf cfg.enable {
    security.sudo.extraConfig = ''
      # rollback results in sudo lectures after each reboot
      Defaults lecture = never
    '';

    programs.fuse.userAllowOther = true;

    # This script does the actual wipe of the system
    # So if it doesn't run, the btrfs system effectively acts like a normal system
    # Taken from https://github.com/NotAShelf/nyx/blob/2a8273ed3f11a4b4ca027a68405d9eb35eba567b/modules/core/common/system/impermanence/default.nix
    boot.initrd.systemd = {
      enable = true;
      services.reset-root = {
        description = "Backup & reset root subvolume";
        wantedBy = [
          "initrd.target"
        ];
        after = [
          # Require `main` be unlocked
          "systemd-cryptsetup@cryptroot.service"
        ];
        before = [
          "sysroot.mount"
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          # Mount the LUKS volume
          mkdir -p /btrfs_tmp
          mount -o subvol=/ /dev/mapper/cryptroot /btrfs_tmp

          # Backup old roots
          if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          fi

          # Function to delete a subvolume
          delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
          }

          # Delete backups older than 30 days
          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
          done

          # Create a shiny new "root" subvolume
          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';
      };
    };

    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/srv"
        "/.cache/nix"
        "/etc/NetworkManager/system-connections"
        "/var/cache"
        "/var/db/sudo"
        "/var/lib"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
