{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.hardware.audio;
in {
  options.megadots.nixos.hardware.audio = {
    enable = mkEnableOption "Whether to enable audio for the system.";
  };
  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pamixer
      pavucontrol
    ];
  };
}
