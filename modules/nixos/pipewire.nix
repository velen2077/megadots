{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.pipewire;
in {
  options.megadots.pipewire = {
    enable = mkEnableOption "Enable pipewire audio services.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
