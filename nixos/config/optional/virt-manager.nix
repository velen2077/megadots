{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/cache/libvirt"
      "/var/lib/libvirt"
      "/var/lib/qemu"
    ];
  };
}
