{
  imports = [
    # Import all core Home Manager modules to apply them
    # all automatically for the user on this system.
    ./common/core
    # Import all optional Home Manager modules. These are
    # then applied using the 'megadots.home.optional.<feature>
    # flags to toggle them on or off and supply values if needed.
    ./common/optional
  ];

  # Here is where the fun happens. All the modules should
  # be loaded through imports, and they can be toggled on or
  # off using the appropriate megadots option.
  megadots.home.optional = {
    alacritty.enable = true;
    firefox.enable = true;
    vscodium.enable = true;
    zsh.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "velen2077";
    userEmail = "velen2077@proton.me";
    aliases = {};
    extraConfig = {
      log.showSignature = "true";
      init.defaultBranch = "main";
      pull.rebase = "true";
      commit.gpgsign = true;
      #gpg.format = "gpg";
      user.signing.key = "8F1B8CFF76C80581";
      # Taken from https://github.com/clemak27/homecfg/blob/16b86b04bac539a7c9eaf83e9fef4c813c7dce63/modules/git/ssh_signing.nix#L14
      #gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

      #save.directory = "${config.home.homeDirectory}/sync/obsidian-vault-01/wiki";
    };
    signing = {
      signByDefault = true;
      key = "8F1B8CFF76C80581";
    };
    ignores = [
      ".csvignore"
      ".direnv"
      "result"
      "*.qcow2"
    ];
  };
}
