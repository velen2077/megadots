{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    element-desktop
  ];

  home.persistence."/persist" = {
    directories = [
      #".config/@filen"
    ];
    files = [
    ];
  };
}
