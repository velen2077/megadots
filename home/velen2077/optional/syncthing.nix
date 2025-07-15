{
  config,
  lib,
  pkgs,
  ...
}: {
  services.syncthing.enable = true;

  home.persistence."/persist" = {
    directories = [
      "syncthing"
      ".config/syncthing"
      ".local/state/syncthing"
    ];
    files = [
    ];
  };
}
