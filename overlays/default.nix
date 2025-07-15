{
  outputs,
  inputs,
}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # This overlay provides a convenient way to access the packages from all
  # flake inputs. For each input, it creates an attribute set under `pkgs.inputs`
  # (e.g., `pkgs.inputs.spicetify-nix`). This makes it easy to use packages
  # from other flakes in your configuration without having to manually dig
  # through `inputs`. It intelligently looks for `packages` or `legacyPackages`
  # on the flake for the current system.
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  # This overlay adds `pkgs.stable` which points to the `nixpkgs-stable`
  # flake input. This allows you to install packages from the stable
  # channel on a system that primarily uses `nixpkgs-unstable`. You can
  # install a stable package with `pkgs.stable.package-name`.
  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };

  #linux-firmware-override = final: prev: {
  #  linux-firmware = prev.linux-firmware.overrideAttrs (old: rec {
  #    version = "20250509";
  #    src = prev.fetchzip {
  #      url = "https://cdn.kernel.org/pub/linux/kernel/firmware/linux-firmware-${version}.tar.xz";
  #      hash = "sha256-0FrhgJQyCeRCa3s0vu8UOoN0ZgVCahTQsSH0o6G6hhY=";
  #    };
  #   });
  #};
}
