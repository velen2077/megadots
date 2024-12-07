{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.disko.nixosModules.disko

    ../common
    # ../common/users/gabriel

    # ../common/optional/peripherals.nix
    # ../common/optional/greetd.nix
    # ../common/optional/pipewire.nix
    # ../common/optional/quietboot.nix
    # ../common/optional/wireless.nix
    # ../common/optional/lxd.nix

    # ../common/optional/starcitizen-fixes.nix
  ];

  modules = {
    bluetooth.enable = true;
    firewall.enable = true;
    pipewire.enable = true;
    quietboot.enable = true;
    virtualisation.enable = true;
    users = {
      velen2077.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    hello
  ];
  networking = {
    hostName = "endgame";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "24.11";
}
