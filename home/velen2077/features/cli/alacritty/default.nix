{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    general = {
      working_directory = config.home.homeDirectory;
    };
  };
}
