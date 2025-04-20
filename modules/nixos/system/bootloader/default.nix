{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.system.bootloader;
in {
  options.megadots.system.bootloader = {
    enable = mkEnableOption "Enable and configure bootloader for the system.";
  };
  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max"; # makes console fill screen
      };
      efi.canTouchEfiVariables = true;
      timeout = 20;
    };
  };
}
