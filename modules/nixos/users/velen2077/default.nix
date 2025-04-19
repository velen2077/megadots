{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.users.velen2077;
in {
  options.megadots.users.velen2077 = {
    enable = mkEnableOption "Enable the velen2077 user account.";
  };
  config = mkIf cfg.enable {
    users.users = {
      # FIXME: Replace with your username
      velen2077 = {
        # TODO: You can set an initial password for your user.
        # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
        # Be sure to change it (using passwd) after rebooting!
        hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        ];
        # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
        extraGroups = ["wheel"];
      };
    };
  };
}
