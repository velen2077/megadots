{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    image = ../../../assets/wallpaper/robogirl.png;
    polarity = "dark";
  };
}
