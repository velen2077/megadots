{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.home.optional.firefox;
in {
  options.megadots.home.optional.firefox = {
    enable = mkEnableOption "Enable and customise the Firefox browser.";
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;

    programs.firefox.policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxScreenshots = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never"; # Previously appeared when pressing alt
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      OverrideFirstRunPage = "";
      PictureInPicture.Enabled = false;
      PromptForDownloadLocation = false;
      HardwareAcceleration = true;
      TranslateEnabled = true;
      Homepage.StartPage = "previous-session";
      UserMessaging = {
        UrlbarInterventions = false;
        SkipOnboarding = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      Handlers.schemes.vscode = {
        action = "useSystemDefault"; # Open VSCode app
        ask = false;
      };
      Handlers.schemes.element = {
        action = "useSystemDefault"; # Open Element app
        ask = false;
      };
    };

    programs.firefox.profiles.default = {
      isDefault = true;
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        proton-pass
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
      };
    };

    programs.firefox.profiles.default.search.engines = {
      "Google".metaData.hidden = true;
      "Bing".metaData.hidden = true;
      "eBay".metaData.hidden = true;
      "Amazon.com".metaData.hidden = true;
      "Wikipedia (en)".metaData.hidden = true;
    };

    programs.firefox.policies.Preferences = {
      "browser.urlbar.suggest.searches" = true; # Need this for basic search suggestions
      "browser.urlbar.shortcuts.bookmarks" = false;
      "browser.urlbar.shortcuts.history" = false;
      "browser.urlbar.shortcuts.tabs" = false;
      "browser.urlbar.placeholderName" = "DuckDuckGo";
      "browser.urlbar.placeholderName.private" = "DuckDuckGo";
      "browser.aboutConfig.showWarning" = false; # No warning when going to config
      "browser.warnOnQuitShortcut" = false;
      "browser.tabs.loadInBackground" = true; # Load tabs automatically
      "media.ffmpeg.vaapi.enabled" = true; # Enable hardware acceleration
      "browser.in-content.dark-mode" = true; # Use dark mode
      "ui.systemUsesDarkTheme" = true;
      "extensions.autoDisableScopes" = 0; # Automatically enable extensions
      "extensions.update.enabled" = false;
      "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
      "signon.management.page.breach-alerts.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;
    };

    #programs.firefox.policies.Preferences."browser.uiCustomization.state" =
    programs.firefox.policies = {
      # extensions
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
      };
    };

    home.file.".mozilla/firefox/default/extension-preferences.json".text =
      builtins.toJSON
      {
        "uBlock0@raymondhill.net" = {
          permissions = ["internal:privateBrowsingAllowed"];
          origins = [];
        };
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          permissions = ["internal:privateBrowsingAllowed"];
          origins = [];
        };
      };

    home.file.".mozilla/firefox/default/extension-preferences.json".force = true;
  };
}
