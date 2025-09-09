{
  config,
  lib,
  pkgs,
  ...
}: {
  services.nextcloud-client = {
    enable = true;
    package = pkgs.nextcloud-client;
    startInBackground = true;
  };

  home.persistence."/persist" = {
    directories = [
      "Nextcloud"
      ".config/Nextcloud"
      ".local/share/Nextcloud"
    ];
    files = [
    ];
  };
}
