{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = "enabled";
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      shell_integration = "enabled";
      allow_remote_control = true;
      enable_audio_bell = false;
      scrollback_lines = 100000;
    };
  };
}
