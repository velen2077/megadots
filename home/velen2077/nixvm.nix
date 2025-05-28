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

  monitors = [
    {
      name = "Virtual-1";
      width = 1920;
      height = 1080;
      primary = true;
    }
  ];
}
