{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users.
    ./global
    # Optional configs to import for this user.
    ./optional/alacritty.nix
    ./optional/code-cursor.nix
    ./optional/digikam.nix
    ./optional/element-desktop.nix
    ./optional/filen-desktop.nix
    ./optional/firefox.nix
    ./optional/gnome.nix
    ./optional/obsidian.nix
    ./optional/signal-desktop.nix
    ./optional/spicetify.nix
    ./optional/terraform.nix
    ./optional/vesktop.nix
    ./optional/vscodium.nix
  ];

  theme = {
    enable = true;
    base16SchemeName = "gruvbox-dark-pale";
    image = ../../assets/wallpaper/robogirl.png;
    polarity = "dark";
    gtkIconThemeName = "Gruvbox-Plus-Dark";
    gtkIconThemePackage = pkgs.gruvbox-plus-icons;
    gtkCursorThemeName = "Bibata-Modern-Classic";
    gtkCursorThemePackage = pkgs.bibata-cursors;
  };

  monitors = [
    {
      name = "DP-2";
      make = "AUS";
      model = "VG27A";
      serial = "LALMQS176787";
      width = 2560;
      height = 1440;
      refreshRate = "143.972";
      workspace = "1";
      primary = true;
    }
  ];
}
