{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.services.polkit;
in {
  options.modules.services.polkit = {
    enable = mkEnableOption "Enable polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
              action.id == "org.freedesktop.login1.suspend" ||
              action.id == "org.freedesktop.login1.suspend-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      })
    '';
  };
}
