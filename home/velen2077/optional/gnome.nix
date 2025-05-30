{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.user-themes
    ];
  };

  dconf.settings = {
    # Don't try to suspend while plugged in.
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    #

    "org/gnome/desktop/interface" = {
      # gtk4 theme/scheme.
      color-scheme = "prefer-dark";
      accent-color = "slate";
      show-battery-percentage = true;
    };

    # Enable minimise, maximise buttons.
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":appmenu,minimize,maximize,close";
    };

    # Wayland Mutter tweaks.
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
    };

    # Touchpad support and config.
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = false;
    };

    # Extension config.
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        user-themes.extensionUuid
      ];
      #favorite-apps = [ "org.gnome.Nautilus.desktop" "kitty.desktop" "chromium-browser.desktop" "code.desktop" ];
      last-selected-power-profile = "performance";
    };
  };

  home.persistence."/persist" = {
    directories = [
      "/var/lib/AccountsService"
      ".config/autostart"
      ".local/share/gvfs-metadata"
      ".local/share/gnome-shell"
    ];
    files = [
    ];
  };
}
