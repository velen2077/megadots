{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.bash-completion];
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        # Clear screen and scrollback
        clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
      };
      functions = {
        # Disable greeting
        fish_greeting = "";
      };
    };
  };

  home.persistence."/persist" = {
    directories = [
      ".config/fish"
      ".local/share/fish"
    ];
    files = [
    ];
  };
}
