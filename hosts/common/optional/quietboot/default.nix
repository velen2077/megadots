{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.quietboot;
in {
  options.modules.quietboot = {
    enable = mkEnableOption "Enable quiet boot module.";
  };

  config = mkIf cfg.enable {
    console = {
      useXkbConfig = true;
      earlySetup = false;
    };

    boot = {
      plymouth = {
        enable = true;
      };
      loader.timeout = 5;
      kernelParams = [
        "quiet"
        "loglevel=3"
        "systemd.show_status=auto"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "vt.global_cursor_default=0"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
  };
}
