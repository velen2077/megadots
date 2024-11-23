{pkgs, ...}: {
  imports = [
    ./common/core
    ./common/optional
  ];

  megadots.home.optional = {
    alacritty.enable = true;
    firefox.enable = true;
    vscodium.enable = true;
    zsh.enable = true;
  };
}
