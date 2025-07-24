{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    digikam
  ];

  home.persistence."/persist" = {
    directories = [
      ".local/share/digikam"
    ];
    files = [
      ".config/digikamrc"
      ".config/digikam_systemrc"
    ];
  };
}
