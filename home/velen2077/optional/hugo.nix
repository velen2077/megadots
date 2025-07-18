{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hugo
  ];

  home.persistence."/persist" = {
    directories = [
    ];
    files = [
    ];
  };
}
