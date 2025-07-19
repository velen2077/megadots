{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      ignores = [
        "result"
        "*.swp"
        "*.qcow2"
      ];

      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };

      #signing = {
      #  key = cfg.key;
      #  signByDefault = true;
      #};

      aliases = {
        s = "status";
        d = "diff";
        a = "add";
        c = "commit";
        p = "push";
        co = "checkout";
      };

      userEmail = "waller.twrw@proton.me";
      userName = "waller-twrw";
    };
  };
}
