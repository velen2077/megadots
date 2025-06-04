{
  inputs,
  lib,
  config,
  ...
}: let
  hasPersistence = config.environment.persistence ? "/persist";
  rollbackScript = ''
    mkdir /mnt
    mount -t btrfs -o subvol=/ /dev/disk/by-label/nixos /mnt
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
in {
  boot.initrd = lib.mkIf (hasPersistence == "/persist") {
    enable = true;
    supportedFilesystems = ["btrfs"];
    systemd.services.rollback = {
      description = "Rollback btrfs root subvolume to a pristine state";
      wantedBy = ["initrd.target"];
      requires = ["dev-disk-by\\x2dlabel-nixos.device"];
      after = [
        "dev-disk-by\\x2dlabel-nixos.device"
        "systemd-cryptsetup@nixos.service"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = rollbackScript;
    };
  };
}
