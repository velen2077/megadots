# Disk configuration file for disko for the host 'nixvm'.
# There are some specific configurations in this disko
# file that are needed for my impermanence setup to work.
# The primary btrfs volume needs to be labelled 'nixos'
# using the extraArgs = ["-L" "nixos" "-f"]; setting,
# and I also use a postCreateHook to generate a blank
# root snapshot when the host is first created.
{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "nixos" "-f"];
                postCreateHook = ''
                  mount -t btrfs /dev/disk/by-label/nixos /mnt
                  btrfs subvolume snapshot -r /mnt /mnt/root-blank
                  umount /mnt
                '';
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "subvol=root"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "subvol=nix"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "subvol=persist"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
