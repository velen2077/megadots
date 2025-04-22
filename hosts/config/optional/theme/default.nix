{pkgs, ...}: {
  # Apply Stylix styling to this system for colour scheming
  # and wallpaper. This applies globally to the system.
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ../../../../assets/wallpaper/cyber.jpg;
  stylix.imageScalingMode = "fill";
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  # Set the system cursor type. I like Bibata Modern Classic.
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
}
