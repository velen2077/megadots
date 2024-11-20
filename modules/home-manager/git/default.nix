{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.git;
in {
  # Create the options for git.
  options.megadots.git = with types; {
    # Enablement option.
    enable = mkEnableOption "Enable git.";
    # Username option for git user.name.
    username = mkOption {
      description = "Username for git.";
      type = types.str;
      default = "";
    };
    # Email option for git user.email.
    email = mkOption {
      description = "Email for git.";
      type = types.str;
      default = "";
    };
    # GPG signing key option for git user.email.
    key = mkOption {
      description = "GPG signing key for git.";
      type = types.str;
      default = "";
    };
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.username;
      userEmail = cfg.email;
      aliases = {};
      extraConfig = {
        log.showSignature = "true";
        init.defaultBranch = "main";
        pull.rebase = "true";
        commit.gpgsign = true;
        gpg.format = "gpg";
        user.signing.key = cfg.key;
      };
      signing = {
        signByDefault = true;
        key = cfg.key;
      };
      ignores = [
        ".csvignore"
        ".direnv"
        "result"
        "*.qcow2"
      ];
    };
  };
}
