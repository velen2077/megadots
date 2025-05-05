{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.optional.grub;
in {
  options.megadots.optional.grub = {
    enable = mkEnableOption "Enable grub.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
      timeout = 30;
    };
  };
}
