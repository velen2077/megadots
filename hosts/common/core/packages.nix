{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Apps installed on all hosts go here.
  environment.systemPackages = with pkgs; [
    alejandra # A code formatter for nix.
    btop # Resource monitor with graphs.
    cava # Audio visualizer.
    easyeffects # Pipewire equalizer.
    fastfetch # System information tool.
    fd # Fast alternative to 'find'.
    fzf # Command-line fuzzy finder.
    gcc # GNU Compiler Collection.
    glib # Low-level core library for GNOME.
    gnumake # Build automation tool.
    grim # Screenshot utility for wayland.
    gsettings-desktop-schemas # GSettings desktop schemas.
    jq # Command-line JSON processor.
    just # A command runner for project-specific commands.
    kitty # GPU-accelerated terminal emulator.
    libnotify # Notification library.
    libsForQt5.qtstyleplugin-kvantum # Qt-theme framework.
    lm_sensors # Hardware monitoring utilities.
    mangohud # Performance overlay for games.
    mpv # Video player.
    mupdf # PDF viewer.
    nemo # Graphical file manager.
    networkmanagerapplet # Network manager GUI.
    neovim # Modern vim-based text editor.
    nvtopPackages.full # GPU process monitor.
    pasystray # Audio settings in tray.
    pavucontrol # PulseAudio volume control.
    pciutils # PCI utilities for device inspection.
    python3 # Python programming language.
    ripgrep # Fast alternative to grep.
    sbctl # Secure Boot utils.
    slurp # Region selector for wayland.
    socat # Listen to events on sockets.
    swtpm # Software-based TPM emulator for vm's.
    tmux # Terminal multiplexer.
    unzip # Zip file extraction utility.
    vim # Terminal text editor.
    wl-clipboard # Wayland clipboard utilities.
    xclip # Command line interface to X clipboard.
    yazi # Terminal file manager.
  ];

  fonts.packages = with pkgs;
    [
      dejavu_fonts
      fira-code
      hack-font
      ibm-plex
      inconsolata
      jetbrains-mono
      liberation_ttf
      noto-fonts
      roboto
      roboto-mono
      source-code-pro
      ttf_bitstream_vera
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
