{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.pipewire;
in {
  options.modules.pipewire = {
    enable = mkEnableOption "Enable pipewire audio system module.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
