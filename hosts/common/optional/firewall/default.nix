{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.firewall;
in {
  options.modules.firewall = with types; {
    enable = mkEnableOption "Enable the firewall.";
  };

  config = mkIf cfg.enable {
    # Enable the firewall.
    networking.firewall.enable = true;
  };
}
