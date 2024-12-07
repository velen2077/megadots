{...}: {
  imports = [
    ./features
    ./global
  ];

  modules = {
    fish.enable = true;
  };

  monitors = [
    {
      name = "HDMI-A-1";
      width = 2560;
      height = 1440;
      workspace = "1";
      primary = true;
    }
  ];
}
