{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global

    ../common/optional/bluetooth
    ../common/optional/gamemode
    ../common/optional/gnome
    ../common/optional/pipewire
    ../common/optional/quietboot
    ../common/optional/systemd-boot

    ../common/users/velen2077
  ];

  environment.systemPackages = with pkgs; [
    hello
  ];
  networking = {
    hostName = "endgame";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "24.11";
}
