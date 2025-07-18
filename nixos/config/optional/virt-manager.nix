{pkgs, ...}: {
  virtualisation = {
    # Enable libvirtd and Docker
    libvirtd = {
      enable = true;
      nss.enable = true;
      qemuPackage = pkgs.qemu;
      qemu.ovmf.enable = true;
    };
  };

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
