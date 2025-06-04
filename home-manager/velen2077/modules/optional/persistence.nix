{
  # The below persistence settings should be applied to
  # all of my NixOS systems. If there are system-specific
  # persistence settings required, add them to the
  # specific module requiring them, or to the system
  # configuration.nix.
  # Global persists for anything that could be global
  # or optional for nixos configs, like Steam.
  home.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "Development"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      ".local/state"
      ".config/sunshine"
      ".local/share/Steam"
      ".steam"
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".pki";
        mode = "0700";
      }
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }
    ];
    files = [
      ".face"
      ".screenrc"
    ];
  };
}
