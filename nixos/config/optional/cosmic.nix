# This module enables the COSMIC desktop environment using the
# packages and modules now available directly in nixpkgs.
{pkgs, ...}: {
  # 1. Enable the COSMIC desktop environment.
  services.desktopManager.cosmic.enable = true;

  # 2. Enable the COSMIC greeter (login screen).
  # This is recommended over using gdm or other display managers.
  services.displayManager.cosmic-greeter.enable = true;

  # 3. Enable the COSMIC session, which is required for the
  # desktop and greeter to function correctly.
  programs.cosmic-session.enable = true;

  # 4. Ensure the necessary fonts are installed. COSMIC uses
  # the 'Fira' font family for its interface.
  fonts.packages = with pkgs; [fira fira-mono fira-code];

  # 5. Optionally, enable Flatpak support for the COSMIC Store.
  # services.flatpak.enable = true;
}
