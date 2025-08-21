{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/Bitwarden"
    ];
    files = [
    ];
  };
}
