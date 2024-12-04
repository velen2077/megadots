# This is a custom module used to apply a GDM logon screen
# avatar/profile picture. It was taken from the issue log
# here: https://github.com/NixOS/nixpkgs/issues/163080#issuecomment-1722465663
# created by jonathan-condor. Requires the 'icon' attribute to
# be set on the user.users.<username> option.
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types;

  iconOptions.options.icon = lib.mkOption {
    type = types.nullOr types.path;
    default = null;
  };

  users = lib.filterAttrs (_: value: value.icon != null) config.users.users;
  iconLinks = lib.mapAttrsToList (name: value: "ln -s ${value.icon} ${name}") users;
  icons = pkgs.runCommand "user-icons" {} ''
    mkdir $out
    cd $out
    ${builtins.concatStringsSep "\n" iconLinks}
  '';

  templateText = lib.generators.toINI {} {
    User.Icon = "${icons}/\${USER}";
  };
  templateFile = pkgs.writeText "user-template" templateText;
  templateDir = "share/accountsservice/user-templates";

  templates = pkgs.runCommand "user-templates" {meta.priority = 0;} ''
    mkdir -p $out/${templateDir}
    cd $out/${templateDir}

    ln -s ${templateFile} administrator
    ln -s ${templateFile} standard
  '';
in {
  options.users.users = lib.mkOption {
    type = types.attrsOf (types.submodule iconOptions);
  };

  config.environment.systemPackages = [templates];
}
