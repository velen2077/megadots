{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.ephemeral-btrfs;
in {
  options.megadots.ephemeral-btrfs = {
    enable = mkEnableOption "Enable ephemeral-btrfs and impermanence.";

    diskLabel = mkOption {
      default = "nixos";
      example = "nixos";
      type = types.str;
      description = ''
        The disk label of the impermanent disk. This is set during
        disko disk partitioning.
      '';
    };

    rollbackScript = mkOption {
      default = ''
        mkdir /mnt
        mount -t btrfs -o subvol=/ /dev/disk/by-label/${cfg.diskLabel} /mnt
        btrfs subvolume list -o /mnt/root | cut -f 9- -d ' ' | while read subvolume; do
          echo "Deleting subvolume: /$subvolume"
          btrfs subvolume delete "/mnt/$subvolume" 1>/dev/null
        done &&
        btrfs subvolume delete /mnt/root 1>/dev/null
        echo "Restoring blank /root subvolume"
        btrfs subvolume snapshot /mnt/root-blank /mnt/root 1>/dev/null
        rm -rf /mnt/root/root && mkdir /mnt/root/root
        umount /mnt
      '';
      type = types.lines;
      description = ''
        The systemd script that will be used to rollback the root
        volume of the given disk (by diskLabel).
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.initrd = {
      enable = true;
      supportedFilesystems = ["btrfs"];
      systemd.services.rollback = {
        description = "Rollback btrfs root subvolume to a pristine state";
        wantedBy = ["initrd.target"];
        requires = ["dev-disk-by\\x2dlabel-${cfg.diskLabel}.device"];
        after = [
          "dev-disk-by\\x2dlabel-${cfg.diskLabel}.device"
          "systemd-cryptsetup@${cfg.diskLabel}.service"
        ];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = cfg.rollbackScript;
      };
    };
  };
}
