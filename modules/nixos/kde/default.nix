{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.kde;
in {
  options.megadots.kde = {
    enable = mkEnableOption "Enable the KDE Plasma desktop environment.";
  };

  config = mkIf cfg.enable {
    # Enable the KDE Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.sddm.enableHidpi = true;
    # services.displayManager.sddm.theme = "breeze-user";

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      MOZ_DISABLE_RDD_SANDBOX = 1;
      NIXOS_OZONE_WL = "1";
      QT_LOGGING_RULES = "*.debug=false";
      GTK_USE_PORTAL = 1;
      GDK_DEBUG = "portals";
    };

    qt = {
      enable = true;
      platformTheme = "kde";
    };

    environment.systemPackages = with pkgs.kdePackages; [
      sddm-kcm
      audiocd-kio
      skanpage
      isoimagewriter
      krdc
      konversation
      breeze-icons
      discover
      partitionmanager
      kclock
      #pkgs.exfatprogs
      #pkgs.leoPkgs.sddm-theme-breeze-user
    ];

    services.desktopManager.plasma6.enable = true;
    xdg.icons.enable = true;

    xdg.portal = {
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      xdgOpenUsePortal = true;
    };
  };
}
