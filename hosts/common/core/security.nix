# This file (and the global directory) holds config that i use on all hosts
{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Enable passwordless sudo for members
  # of wheel group.
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };

  # The default open file limit is often too low for modern applications,
  # especially for development, gaming, and other intensive tasks. Increasing
  # this limit prevents "too many open files" errors.
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
