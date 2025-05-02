{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.optional.gpu-screen-recorder;
in {
  options.megadots.optional.gpu-screen-recorder = {
    enable = mkEnableOption "Enable gpu-screen-recorder.";
  };

  config = mkIf cfg.enable {
    programs.gpu-screen-recorder.enable = true;
    environment.systemPackages = [pkgs.gpu-screen-recorder-gtk];
  };
}
