{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.system.nix;
in {
  options.megadots.nixos.system.nix = with types; {
    enable = mkEnableOption "Whether to enable the nix settings.";

    stateVersion = mkOption {
      type = str;
      default = "24.11";
      example = "24.11";
      description = "
        The state version to apply to this system. It should be
        provided in the standard ##.## string format.
      ";
    };
  };

  config = mkIf cfg.enable {
    #nixpkgs.config.allowUnfree = true;
    home-manager.backupFileExtension = "backup";
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://chaotic-nyx.cachix.org/"
      ];
      trusted-public-keys = [
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };

    # Optimize storage and automatic scheduled GC running.
    # If you want to run GC manually, use commands:
    # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths.
    # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths.
    # `nix-collect-garbage -d` for deleting old generations of user profiles.
    nix.settings.auto-optimise-store = true;
    nix.optimise.automatic = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };

    # Set the appropriate state version passed through from the flake.
    system.stateVersion = cfg.stateVersion;
  };
}
