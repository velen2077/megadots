{
  lib,
  pkgs,
  config,
  ...
}: {
  console = {
    useXkbConfig = true;
    earlySetup = false;
  };

  boot = {
    plymouth = {
      enable = true;
      theme = lib.mkForce "hexagon_dots_alt";
      themePackages = with pkgs; [
        # By default we would install all themes.
        (adi1090x-plymouth-themes.override {
          selected_themes = ["hexagon_dots_alt"];
        })
      ];
    };
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
}
