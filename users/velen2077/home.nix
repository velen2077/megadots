{
  stateVersion,
  username,
  ...
}: {
  imports = [
    ../../modules/home-manager
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = stateVersion;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  megadots = {
    alacritty.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      username = "velen2077";
      email = "velen2077@proton.me";
      key = "8F1B8CFF76C80581";
    };
    zsh.enable = true;
  };
}
