{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.locale;
in {
  options.megadots.locale = {
    enable = mkEnableOption "Enable system locale settings.";

    timezone = mkOption {
      default = "Europe/London";
      example = "Europe/London";
      type = types.str;
      description = mdDoc ''
        The timezone to be used.
      '';
    };

    locale = mkOption {
      default = "en_GB";
      example = "en_GB";
      type = types.str;
      description = mdDoc ''
        The locale to be used.
      '';
    };

    keyboardLayout = mkOption {
      default = "gb";
      example = "gb";
      type = types.str;
      description = mdDoc ''
        The keyboard layout to be used.
      '';
    };

    consoleKeyMap = mkOption {
      default = "uk";
      example = "uk";
      type = types.str;
      description = mdDoc ''
        The console key map layout to be used.
      '';
    };
  };

  config = mkIf cfg.enable {
    # Set the time zone.
    time.timeZone = mkDefault cfg.timezone;

    # Select internationalisation properties.
    i18n.defaultLocale = "${cfg.locale}.UTF-8";

    # Configure additional locales.
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "${cfg.locale}.UTF-8";
      LC_IDENTIFICATION = "${cfg.locale}.UTF-8";
      LC_MEASUREMENT = "${cfg.locale}.UTF-8";
      LC_MONETARY = "${cfg.locale}.UTF-8";
      LC_NAME = "${cfg.locale}.UTF-8";
      LC_NUMERIC = "${cfg.locale}.UTF-8";
      LC_PAPER = "${cfg.locale}.UTF-8";
      LC_TELEPHONE = "${cfg.locale}.UTF-8";
      LC_TIME = "${cfg.locale}.UTF-8";
    };

    # Update the xkb layout to British.
    services.xserver = {
      xkb.layout = mkForce cfg.keyboardLayout;
    };

    # Configure console keymap.
    console.keyMap = mkForce cfg.consoleKeyMap;
  };
}
