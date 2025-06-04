{lib, ...}: {
  # Disable speechd as I don't use it on any system.
  services.speechd.enable = lib.mkDefault false;
}
