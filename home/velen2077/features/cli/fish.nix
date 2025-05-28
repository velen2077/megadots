{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.bash-completion];
  programs = {
    fish = {
      enable = true;
      shellAbbrs = rec {
        jqless = "jq -C | less -r";

        n = "nix";
        nd = "nix develop -c $SHELL";
        ns = "nix shell";
        nsn = "nix shell nixpkgs#";
        nb = "nix build";
        nbn = "nix build nixpkgs#";
        nf = "nix flake";

        nr = "nixos-rebuild --flake .";
        nrs = "nixos-rebuild --flake . switch";
        snr = "sudo nixos-rebuild --flake .";
        snrs = "sudo nixos-rebuild --flake . switch";
        hm = "home-manager --flake .";
        hms = "home-manager --flake . switch";
      };
      shellAliases = {
        # Clear screen and scrollback
        clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
      };
      functions = {
        # Disable greeting
        fish_greeting = "";
      };
    };
    # Minimal, blazing-fast, and infinitely customizable prompt for any shell.
    starship = {
      enable = true;
      enableFishIntegration = true;
      # Fish shell only.
      enableInteractive = true;
      enableTransience = true;
    };
    # Shell integrations.
    kitty.shellIntegration.enableFishIntegration = true;
    nix-your-shell.enableFishIntegration = true;
    zoxide.enableFishIntegration = true;
  };
}
