{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Disabling speechd, the speech dispatcher daemon, as it's not
  # needed for most desktop use cases and can consume resources.
  services.speechd.enable = lib.mkDefault false;
  # thermald helps prevent CPU's from overheating.
  services.thermald.enable = true;
  services.upower.enable = true;
}
