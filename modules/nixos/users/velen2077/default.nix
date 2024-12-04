{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.megadots.nixos.users.velen2077;
in {
  options.megadots.nixos.users.velen2077 = with types; {
    enable = mkEnableOption "Whether to enable the user velen2077.";
  };

  config = mkIf cfg.enable {
    users.users.velen2077 = {
      isNormalUser = true;
      hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
      description = "velen2077";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      createHome = true;
      shell = pkgs.zsh;
      packages = with pkgs; [zsh];
      icon = mkIf (config.megadots.nixos.desktop.gnome.enable) ../../../../assets/avatars/velen2077.png;
      openssh.authorizedKeys.keys = [
        (builtins.readFile ./id_ed25519.pub)
      ];
    };
    programs.zsh.enable = true;
  };
}
