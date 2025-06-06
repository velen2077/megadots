# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  bluetooth = import ./bluetooth.nix;
  cachyos = import ./cachyos.nix;
  ephemeral-btrfs = import ./ephemeral-btrfs.nix;
  fish = import ./fish.nix;
  gaming = import ./gaming.nix;
  gnome = import ./gnome.nix;
  graphics = import ./graphics.nix;
  locale = import ./locale.nix;
  persistence = import ./persistence.nix;
  pipewire = import ./pipewire.nix;
  theme = import ./theme.nix;
  thermald = import ./thermald.nix;
  upower = import ./upower.nix;
  virt-manager = import ./virt-manager.nix;
}
