{outputs}: {
  imports =
    [
      ./core
      ./optional
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  megadots = {
    optional = {
      firefox.enable = true;
      vscodium.enable = true;
    };
  };
}
