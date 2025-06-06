{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.virt-manager;
in {
  options.megadots.virt-manager = {
    enable = mkEnableOption "Enable virt-manager and virtualisation.";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager = {
      enable = true;
      package = pkgs.virt-manager;
    };

    environment.persistence."/persist" = mkIf config.megadots.persistence.enable {
      directories = [
        "/var/lib/libvirt"
        "/var/lib/qemu"
      ];
    };
  };
}
