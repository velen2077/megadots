{
  config,
  pkgs,
  ...
}: {
  # Define my user velen2077.
  # Mutable users should be set to false for
  # impermanence to work, as the user will be
  # deleted on each reboot if set to true.
  users.mutableUsers = false;
  # TODO Make sure the username is correct.
  users.users.velen2077 = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
    ];
    hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    # TODO Make sure to add the users ssh public key.
    # Bring along my users public ssh key.
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_ed25519.pub)
    ];
    # These packages will be installed on the
    # system, in a user context.
    packages = with pkgs; [
      home-manager
    ];
  };
  # Import the users Home Manager config.
  home-manager.users.velen2077 = import ../../../../home-manager/velen2077/systems/${config.networking.hostName}.nix;
}
