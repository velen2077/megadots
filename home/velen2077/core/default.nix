{
  imports =
    [
      ./alacritty
      ./fish
      ./git
      ./home-manager
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);
}
