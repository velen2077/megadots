{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    ./core
    ./optional
  ];

  megadots = {
    optional = {
      firefox.enable = true;
      vscodium.enable = true;
    };
  };
}
