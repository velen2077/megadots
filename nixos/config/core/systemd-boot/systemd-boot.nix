{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.optional.systemd-boot;
in {
  options.megadots.optional.systemd-boot = {
    enable = mkEnableOption "Enable systemd-boot.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 30;
      systemd-boot = {
        enable = true;

        windows = {
          "windows" = let
            # To determine the name of the windows boot drive, boot into edk2 first, then run
            # `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
            # which alias corresponds to which EFI partition.
            boot-drive = "FS2";
          in {
            title = "Windows";
            efiDeviceHandle = boot-drive;
            sortKey = "y_windows";
          };
        };

        edk2-uefi-shell.enable = false;
        edk2-uefi-shell.sortKey = "z_edk2";
      };
    };
  };
}
