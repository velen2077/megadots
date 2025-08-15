{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.theme = {
    borderRadius = lib.mkOption {
      type = lib.types.int;
      default = 4;
    };
    borderWidth = lib.mkOption {
      type = lib.types.int;
      default = 2;
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.9;
    };
    spacing = lib.mkOption {
      type = lib.types.submodule {
        options = {
          xxs = lib.mkOption {
            type = lib.types.int;
            default = 2;
          };
          xs = lib.mkOption {
            type = lib.types.int;
            default = 4;
          };
          s = lib.mkOption {
            type = lib.types.int;
            default = 8;
          };
          m = lib.mkOption {
            type = lib.types.int;
            default = 12;
          };
          xxl = lib.mkOption {
            type = lib.types.int;
            default = 24;
          };
        };
      };
      default = {};
    };

    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Optional path to a wallpaper image to use in tools like hyprpaper or swaybg.
        If unset, no wallpaper will be applied.
      '';
      example = ./wallpapers/forest.jpg;
    };

    # Stylix configuration
    stylix = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable Stylix theming";
          };
          base16Scheme = lib.mkOption {
            type = lib.types.str;
            default = "rose-pine";
            description = "Base16 scheme name (without path and extension)";
            example = "rose-pine";
          };
          polarity = lib.mkOption {
            type = lib.types.enum ["light" "dark"];
            default = "dark";
            description = "Color scheme polarity";
          };
          disableTargets = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "List of targets to disable theming for";
            example = ["waybar" "gdm"];
          };
          firefoxProfiles = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = ["default"];
            description = "List of Firefox profile names to theme";
            example = ["default" "work"];
          };
        };
      };
      default = {};
    };

    # default scheme is gruvbox
    colors = lib.mkOption {
      type = lib.types.submodule {
        options = {
          base00 = lib.mkOption {
            type = lib.types.str;
            default = "282828";
          }; # bg
          base01 = lib.mkOption {
            type = lib.types.str;
            default = "3c3836";
          }; # bg1
          base02 = lib.mkOption {
            type = lib.types.str;
            default = "504945";
          }; # bg2
          base03 = lib.mkOption {
            type = lib.types.str;
            default = "665c54";
          }; # bg3
          base04 = lib.mkOption {
            type = lib.types.str;
            default = "bdae93";
          }; # fg2
          base05 = lib.mkOption {
            type = lib.types.str;
            default = "d5c4a1";
          }; # fg1
          base06 = lib.mkOption {
            type = lib.types.str;
            default = "ebdbb2";
          }; # fg0
          base07 = lib.mkOption {
            type = lib.types.str;
            default = "fbf1c7";
          }; # fg
          base08 = lib.mkOption {
            type = lib.types.str;
            default = "fb4934";
          }; # red
          base09 = lib.mkOption {
            type = lib.types.str;
            default = "fe8019";
          }; # orange
          base0A = lib.mkOption {
            type = lib.types.str;
            default = "fabd2f";
          }; # yellow
          base0B = lib.mkOption {
            type = lib.types.str;
            default = "b8bb26";
          }; # green
          base0C = lib.mkOption {
            type = lib.types.str;
            default = "8ec07c";
          }; # aqua
          base0D = lib.mkOption {
            type = lib.types.str;
            default = "83a598";
          }; # blue
          base0E = lib.mkOption {
            type = lib.types.str;
            default = "d3869b";
          }; # purple
          base0F = lib.mkOption {
            type = lib.types.str;
            default = "d65d0e";
          }; # brown
        };
      };
      default = {};
    };

    # GTK configuration
    gtk = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable GTK theming";
          };
          iconTheme = lib.mkOption {
            type = lib.types.submodule {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  default = "Gruvbox-Plus-Dark";
                  description = "GTK icon theme name";
                };
                package = lib.mkOption {
                  type = lib.types.package;
                  default = pkgs.gruvbox-plus-icons;
                  description = "Package providing the icon theme";
                };
              };
            };
            default = {};
          };
        };
      };
      default = {};
    };

    # QT configuration
    qt = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable QT theming";
          };
        };
      };
      default = {};
    };

    # Cursor configuration
    cursor = lib.mkOption {
      type = lib.types.submodule {
        options = {
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.bibata-cursors;
            description = "Package providing the cursor theme";
          };
          name = lib.mkOption {
            type = lib.types.str;
            default = "Bibata-Modern-Classic";
            description = "Cursor theme name";
          };
          size = lib.mkOption {
            type = lib.types.int;
            default = 22;
            description = "Cursor size in pixels";
          };
        };
      };
      default = {};
    };
  };

  # Set colors from stylix if available, otherwise use defaults
  config.theme.colors = lib.mkIf config.theme.stylix.enable {
    base00 = config.lib.stylix.colors.base00;
    base01 = config.lib.stylix.colors.base01;
    base02 = config.lib.stylix.colors.base02;
    base03 = config.lib.stylix.colors.base03;
    base04 = config.lib.stylix.colors.base04;
    base05 = config.lib.stylix.colors.base05;
    base06 = config.lib.stylix.colors.base06;
    base07 = config.lib.stylix.colors.base07;
    base08 = config.lib.stylix.colors.base08;
    base09 = config.lib.stylix.colors.base09;
    base0A = config.lib.stylix.colors.base0A;
    base0B = config.lib.stylix.colors.base0B;
    base0C = config.lib.stylix.colors.base0C;
    base0D = config.lib.stylix.colors.base0D;
    base0E = config.lib.stylix.colors.base0E;
    base0F = config.lib.stylix.colors.base0F;
  };

  # Configure stylix if enabled
  config.stylix = lib.mkIf config.theme.stylix.enable {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.theme.stylix.base16Scheme}.yaml";
    polarity = config.theme.stylix.polarity;
    image = lib.mkIf (config.theme.wallpaper != {}) config.theme.wallpaper;
    targets =
      {
        # Firefox is always configured with specified profiles
        firefox = {
          profileNames = config.theme.stylix.firefoxProfiles;
        };
      }
      // (lib.mapAttrs (name: _: {enable = false;})
        (lib.genAttrs config.theme.stylix.disableTargets (_: {})));
  };

  # Configure GTK if enabled
  config.gtk = lib.mkIf config.theme.gtk.enable {
    enable = true;
    iconTheme = config.theme.gtk.iconTheme;
  };

  # Configure QT if enabled
  config.qt = lib.mkIf config.theme.qt.enable {
    enable = true;
  };

  # Configure cursor theme
  config.home.pointerCursor = lib.mkIf (config.theme.cursor != {}) {
    package = config.theme.cursor.package;
    name = config.theme.cursor.name;
    size = config.theme.cursor.size;
  };
}
