{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = ["quiet"];
}
