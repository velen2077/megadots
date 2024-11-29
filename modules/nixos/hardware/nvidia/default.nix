{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.hardware.nvidia;
in {
  options.megadots.nixos.hardware.nvidia = {
    enable = mkEnableOption "Whether to enable nvidia graphics for the system.";
  };
  config = mkIf cfg.enable {
    # Yes, I use nvidia graphics in my daily driver. I'm sorry.
    # I will soon be over to team red, but for now, this will
    # have to suffice.
    services.xserver.videoDrivers = ["nvidia"];
    #nixpkgs.config.allowUnfree = true;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [libva vaapiVdpau];
      };
    };

    nixpkgs.config.nvidia.acceptLicense = true;
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # .latest or .beta for options here.
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
