{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    code-cursor
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/cursor"
    ];
    files = [
    ];
  };
}
