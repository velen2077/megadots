{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  # The configuration for this module will be under 'config.theme'.
  # megadots are configured with user theming only. The intention
  # is that the system-level theme will be DE/WM default, with
  # users able to customise their own experience. This is difficult
  # to achieve with Stylix across both system and user.
  cfg = config.theme;

  # Helper to construct the full path to a Base16 scheme YAML file.
  buildBase16SchemePath = schemeName: "${pkgs.base16-schemes}/share/themes/${schemeName}.yaml";
in {
  # Import the Stylix Home Manager module to enable its functionality
  # for the user's desktop environment and applications.
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  # Define the options available for theme configuration.
  options.theme = {
    enable = mkEnableOption ''
      Enable the unified Home Manager theme configuration for this user.
      Set to `true` to apply the theme settings defined in this module.
    '';

    base16SchemeName = mkOption {
      type = types.str;
      default = "gruvbox-dark-pale";
      description = ''
        The name of the Base16 scheme to use for theming terminals,
        applications, and other elements (e.g., GTK, Qt, shell).
      '';
      example = "nord";
    };

    image = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        Path to the wallpaper image for the user's desktop background.
        Set to `null` if you prefer to use the system default wallpaper
        or have no custom image.
      '';
      example = "${config.home.homeDirectory}/.backgrounds/my-custom-wallpaper.png";
    };

    polarity = mkOption {
      type = types.enum ["dark" "light"];
      default = "dark";
      description = ''
        The global color polarity (dark or light) for Stylix and other
        user interface elements. This affects the overall brightness
        of the theme.
      '';
      example = "light";
    };

    gtkThemeName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        The name of the GTK theme to use (e.g., "Adwaita-dark", "Catppuccin-Latte").
        Set to `null` to use the system default or no specific GTK theme,
        relying on other theme aspects or applications' own defaults.
      '';
      example = "Adwaita-dark";
    };

    gtkThemePackage = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = ''
        The Nix package providing the GTK theme (e.g., `pkgs.adwaita-qt`,
        `pkgs.catppuccin-gtk`). Set to `null` if no custom GTK theme package
        is needed.
      '';
      example = "pkgs.adwaita-qt";
    };

    gtkIconThemeName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        The name of the GTK icon theme to use (e.g., "Adwaita", "Papirus").
        Set to `null` to use the system default or no specific icon theme.
      '';
      example = "Adwaita";
    };

    gtkIconThemePackage = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = ''
        The Nix package providing the GTK icon theme (e.g., `pkgs.adwaita-icon-theme`,
        `pkgs.papirus-icon-theme`). Set to `null` if no custom icon theme
        package is needed.
      '';
      example = "pkgs.adwaita-icon-theme";
    };

    gtkCursorThemeName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        The name of the GTK cursor theme to use (e.g., "Adwaita", "Bibata").
        Set to `null` to use the system default or no specific cursor theme.
      '';
      example = "Adwaita";
    };

    gtkCursorThemePackage = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = ''
        The Nix package providing the GTK cursor theme (e.g., `pkgs.adwaita-icon-theme`,
        `pkgs.bibata-cursors`). Set to `null` if no custom cursor theme
        package is needed.
      '';
      example = "pkgs.adwaita-icon-theme";
    };

    gtkCursorThemeSize = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The size of the GTK cursor theme in pixels (e.g., 24, 32).
        Set to `null` to use the default size for the chosen cursor theme.
      '';
      example = 24;
    };

    fonts = {
      sansSerif = {
        name = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = ''
            The name of the sans-serif font for the user's desktop environment
            and applications. Set to `null` to rely on system defaults.
          '';
          example = "Cantarell";
        };
        package = mkOption {
          type = types.nullOr types.package;
          default = null;
          description = ''
            The Nix package providing the sans-serif font
            (e.g., `pkgs.noto-fonts`, `pkgs.cantarell-fonts`).
            Set to `null` if no specific font package is desired.
          '';
          example = "pkgs.cantarell-fonts";
        };
      };

      serif = {
        name = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = ''
            The name of the serif font. Set to `null` to rely on system defaults
            or Stylix's internal defaults for serif fonts.
          '';
          example = "DejaVu Serif";
        };
        package = mkOption {
          type = types.nullOr types.package;
          default = null;
          description = ''
            The Nix package providing the serif font (e.g., `pkgs.dejavu_fonts`).
            Set to `null` if no specific serif font package is desired.
          '';
          example = "pkgs.dejavu_fonts";
        };
      };

      monospace = {
        name = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = ''
            The name of the monospace font for terminals, code editors,
            and other fixed-width text displays. Set to `null` to rely on
            system defaults for monospace fonts.
          '';
          example = "Fira Code";
        };
        package = mkOption {
          type = types.nullOr types.package;
          default = null;
          description = ''
            The Nix package providing the monospace font (e.g., `pkgs.fira-code`,
            `pkgs.jetbrains-mono`). Set to `null` if no specific monospace font
            package is desired.
          '';
          example = "pkgs.noto-fonts-monospace";
        };
      };

      emoji = {
        name = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = ''
            The name of the emoji font. Set to `null` to rely on system defaults
            or Stylix's internal defaults for emoji fonts.
          '';
          example = "Noto Color Emoji";
        };
        package = mkOption {
          type = types.nullOr types.package;
          default = null;
          description = ''
            The Nix package providing the emoji font (e.g., `pkgs.noto-fonts-emoji`).
            Set to `null` if no specific emoji font package is desired.
          '';
          example = "pkgs.noto-fonts-emoji";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = buildBase16SchemePath cfg.base16SchemeName;
      polarity = cfg.polarity;

      # Apply the image only if it's explicitly set (i.e., not null).
      # This prevents Stylix from trying to use a non-existent image path.
      image = lib.mkIf (cfg.image != null) cfg.image;

      # Firefox specific tweaks.
      targets.firefox.profileNames = ["default"];

      # Stylix itself handles setting fonts for applications and desktop environments.
      fonts = {
        sansSerif = lib.optionalAttrs (cfg.fonts.sansSerif.name != null) {
          name = cfg.fonts.sansSerif.name;
          package = lib.mkIf (cfg.fonts.sansSerif.package != null) cfg.fonts.sansSerif.package;
        };
        serif = lib.optionalAttrs (cfg.fonts.serif.name != null) {
          name = cfg.fonts.serif.name;
          package = lib.mkIf (cfg.fonts.serif.package != null) cfg.fonts.serif.package;
        };
        monospace = lib.optionalAttrs (cfg.fonts.monospace.name != null) {
          name = cfg.fonts.monospace.name;
          package = lib.mkIf (cfg.fonts.monospace.package != null) cfg.fonts.monospace.package;
        };
        emoji = lib.optionalAttrs (cfg.fonts.emoji.name != null) {
          name = cfg.fonts.emoji.name;
          package = lib.mkIf (cfg.fonts.emoji.package != null) cfg.fonts.emoji.package;
        };
      };
    };

    # GTK Configuration.
    # GTK theming is enabled generally, but specific theme properties
    # are only applied if a theme name is provided by the user.
    gtk = {
      enable = true;

      # Apply GTK theme name and package only if gtkThemeName is set.
      theme = lib.optionalAttrs (cfg.gtkThemeName != null) {
        name = cfg.gtkThemeName;
        # Apply theme package only if gtkThemePackage is also set.
        package = lib.mkIf (cfg.gtkThemePackage != null) cfg.gtkThemePackage;
      };

      # Apply GTK icon theme name and package only if gtkIconThemeName is set.
      iconTheme = lib.optionalAttrs (cfg.gtkIconThemeName != null) {
        name = cfg.gtkIconThemeName;
        package = lib.mkIf (cfg.gtkIconThemePackage != null) cfg.gtkIconThemePackage;
      };

      # Apply GTK cursor theme name and package only if gtkCursorThemeName is set.
      cursorTheme = lib.optionalAttrs (cfg.gtkCursorThemeName != null) {
        name = cfg.gtkCursorThemeName;
        package = lib.mkIf (cfg.gtkCursorThemePackage != null) cfg.gtkCursorThemePackage;
        size = lib.mkIf (cfg.gtkCursorThemeSize != null) cfg.gtkCursorThemeSize;
      };
    };

    # Home Manager fonts module, primarily for fontconfig.
    # We still enable fontconfig for proper font rendering.
    fonts = {
      fontconfig = {enable = true;};
    };

    # Conditionally add font packages to home.packages list.
    # These packages are installed regardless of whether Stylix uses them,
    # making them available system-wide for the user.
    home.packages =
      (lib.optionals (cfg.fonts.sansSerif.package != null) [cfg.fonts.sansSerif.package])
      ++ (lib.optionals (cfg.fonts.serif.package != null) [cfg.fonts.serif.package])
      ++ (lib.optionals (cfg.fonts.monospace.package != null) [cfg.fonts.monospace.package])
      ++ (lib.optionals (cfg.fonts.emoji.package != null) [cfg.fonts.emoji.package]);
  };
}
