{
  inputs,
  lib,
  config,
  ...
}: let
  wipeScript = ''
    mkdir /mnt
    mount -t btrfs -o subvol=/ /dev/disk/by-label/nixos /mnt
    btrfs subvolume list -o /mnt/root | cut -f 9- -d ' ' | while read subvolume; do
      echo "deleting subvolume: /$subvolume..."
      btrfs subvolume delete "/mnt/$subvolume" 1>/dev/null
    done &&
    btrfs subvolume delete /mnt/root 1>/dev/null
    echo "restoring blank /root subvolume..."
    btrfs subvolume snapshot /mnt/root-blank /mnt/root 1>/dev/null
    rm -rf /mnt/root/root && mkdir /mnt/root/root
    umount /mnt
  '';
  phase1Systemd = config.boot.initrd.systemd.enable;
in {
  boot.initrd = {
    enable = true;
    supportedFilesystems = ["btrfs"];
    postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
    systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = ["initrd.target"];
      requires = ["dev-disk-by\\x2dlabel-nixos.device"];
      after = [
        "dev-disk-by\\x2dlabel-nixos.device"
        "systemd-cryptsetup@nixos.service"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = wipeScript;
    };
  };
}
