{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.user;
in {
  options.megadots.nixos.user = with types; {
    name = mkOption {
      type = str;
      default = "user";
      example = "user";
      description = "The username for the user.*";
    };

    initialHashedPassword = mkOption {
      type = str;
      default = "$y$j9T$fYIym0lt7Vc5wEQ93Y6Rr0$ae5ulpqVpRz6A/Zzl52XJhvJZTTgzfzbhOrtAoJP1q0";
      example = "$y$j9T$fYIym0lt7Vc5wEQ93Y6Rr0$ae5ulpqVpRz6A/Zzl52XJhvJZTTgzfzbhOrtAoJP1q0";
      description = "The hashed password for the user. Use mkpasswd -s 'password' to create a hashed password.*";
    };

    extraGroups = mkOption {
      type = listOf str;
      default = "";
      example = "wheel audio network";
      description = "The extra groups the user should be a member of.";
    };

    extraOptions = mkOption {
      type = attrs;
      default = "";
      example = "[wheel audio network]";
      description = "Extra options passed to the users.user.<name> object.";
    };

    homeEnabled = mkOption {
      type = bool;
      default = false;
      example = "true";
      description = "Enable the Home Manager module for the user.";
    };

    homeFile = mkOption {
      type = path;
      default = "home.nix";
      example = "../../../home/<username>/<hostname>.nix";
      description = "The Home Manager file for the user, specific to this system.";
    };
  };

  config = {
    users.mutableUsers = false;
    users.users.${cfg.name} =
      {
        isNormalUser = true;
        inherit (cfg) name initialPassword;
        home = "/home/${cfg.name}";
        group = "users";
        extraGroups =
          [
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;

    home-manager = lib.mkIf (cfg.homeEnabled) {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
