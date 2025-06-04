{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };

  services.sunshine = {
    enable = true;
    autoStart = false;
    package = pkgs.sunshine.override {cudaSupport = true;};
    openFirewall = true;
    capSysAdmin = true;
    settings = {
      sunshine_name = config.networking.hostName;
    };
    applications = {
      apps = [
        {
          name = "Steam Big Picture";
          output = "/tmp/sunlight-steam.txt";
          detached = ["${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/bigpicture"];
          image-path = "steam.png";
        }
      ];
    };
  };

  # Required to simulate input in sunshine.
  services.udev.extraRules = lib.optionalString config.services.sunshine.enable ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}
