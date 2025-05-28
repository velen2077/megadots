{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    ./global
    ./features/development
    ./features/productivity
  ];
}
