{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
  ];

  hardware.steam-hardware.enable = true;

  programs = {
    gamescope = {
      args = ["--rt"];
      capSysNice = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession = {
        enable = true;
        args = [
          "--fsr-sharpness 10"
          "-U"
          "--adaptive-sync"
        ];
      };
    };

    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
      };
    };
  };
}
