{
  boot.initrd.systemd.enable = true;

  # Fix for GDM login issues when using
  # plymouth (exhibits by throwing you back
  # to login screen if network hasn't
  # connected yet).
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}
