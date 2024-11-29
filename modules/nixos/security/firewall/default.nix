{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.security.firewall;
in {
  options.megadots.nixos.security.firewall = with types; {
    enable = mkEnableOption "Whether to enable the firewall.";
  };

  config = mkIf cfg.enable {
    # Enable the firewall.
    networking.firewall.enable = true;
  };
}
