{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.theme;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  options.megadots.theme = {
    enable = mkEnableOption "Enable NixOS system themeing.";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
      image = ../../assets/wallpaper/robogirl.png;
      polarity = "dark";
    };
  };
}
