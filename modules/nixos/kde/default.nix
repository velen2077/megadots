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
    networking.networkmanager.enable = true;

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      MOZ_DISABLE_RDD_SANDBOX = 1;
      NIXOS_OZONE_WL = 1;
    };

    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      khelpcenter
      krdp
    ];

    environment.systemPackages = with pkgs; [
      nvidia-vaapi-driver
      kdePackages.sddm-kcm
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
      '')
      networkmanager-openvpn
    ];
  };
}
