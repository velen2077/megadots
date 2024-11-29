{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.services.ssh;
in {
  options.megadots.nixos.services.ssh = with types; {
    enable = mkEnableOption "Whether to enable SSH.";
  };

  config = mkIf cfg.enable {
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
  };
}
