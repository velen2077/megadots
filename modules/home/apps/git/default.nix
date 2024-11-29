{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.home.apps.git;
in {
  # Create the options for git.
  options.megadots.home.apps.git = with types; {
    # Enablement option.
    enable = mkEnableOption "Enable and customise git.";
    # Username option for git user.name.
    username = mkOption {
      type = types.str;
      default = "";
      example = "velen2077";
      description = "
        Specify the user name of the git user.
      ";
    };
    # Email option for git user.email.
    email = mkOption {
      type = types.str;
      default = "";
      example = "velen2077@proton.me";
      description = "
        Specify the email address of the git user.
      ";
    };
    # GPG signing key option for git user.email.
    key = mkOption {
      type = types.str;
      default = "";
      example = "8F1B8CFF76C80581";
      description = "
        Specify the GPG signing key of the git user.
      ";
    };
  };
  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        lfs.enable = true;

        ignores = [
          "result"
          "*.swp"
          "*.qcow2"
        ];

        extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = false;
        };

        signing = {
          key = cfg.key;
          signByDefault = true;
        };

        aliases = {
          s = "status";
          d = "diff";
          a = "add";
          c = "commit";
          p = "push";
          co = "checkout";
        };

        userEmail = cfg.email;
        userName = cfg.username;
      };
    };
  };
}
