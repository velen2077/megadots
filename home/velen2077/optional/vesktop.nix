{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vesktop = {
    enable = true;
  };

  home.persistence."/persist" = {
    directories = [
      ".config/vesktop"
    ];
    files = [
    ];
  };
}
