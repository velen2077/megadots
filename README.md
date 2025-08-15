<p align="center">
  <img src="assets/images/megadots.png" alt="megadots by velen2077"/>
</p>

<p align="center">
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-25.05-blue?style=for-the-badge&logo=NixOS" alt="NixOS"></a>
  <a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/Home--Manager-25.05-blue?style=for-the-badge&logo=Home-Assistant" alt="Home Manager"></a>
</p>

# megadots

My modular, flake-based repo for managing my systems using Nix and NixOS, flakes and Home Manager (as a NixOS module). I publish megadots to help others, as I found Github and other peoples repos (some shoutouts below!) extremely helpful to learn Nix/NixOS. Hopefully I can return the favour by publishing my own, for those who come after.

> **Note:** Though I use this repo for my own config, I also dabble and break things from time to time. I tend to keep working code in the `main` branch. Any other branch, assume it is a work in progress and not suitable for use. Also note that as this is my primary personal config, my `hardware-configuration.nix` files and attributes like `hostname`, `hashedPassword` and `username` will be unique to me, so you'll have to bring your own.

## Introduction

This is my personal system configuration repo that I use to build systems and homes in conjunction with NixOS, Home Manager and flakes. I started out this journey based on sheer curiosity and a desire to have a somewhat declaritive composition to system management (I distro hop - a lot). Some searching online lead me down the garden path that is NixOS, and here I am. Down the rabbit hole.

I am not an expert in Nix, NixOS, Home Manager or flakes. Nor am I a developer. Outside of my consultancy job (in a technical field so not completely in the dark), I'm a tinkerer. I'd been feeling a little burnt out and in need of something to learn in my downtime, and this project came along at the perfect time, and has genuinely brought some fun back in to computing for me. Just like the days of old, going to the local monthly computer market and picking up a fresh copy of a new Linux distro on a wad of floppies and taking it for a spin.

## Features
- **NixOS** system configuration on mulitple hosts.
- **Home Manager** user configuration for my user.
- **Optional Impermanence** with LUKS encrypted btrfs snapshot and rollback.
- **Optional Secure Boot** with lanzaboote, including support for dual boot with Windows.
- **Flakes** and modular configs.
- **Disko** for disk partioning and preperation.
- **Chaotic** inputs for CachyOS kernel.

## Usage

This configuration has a multiple system entry points, with Home Manager configured as a NixOS module. At the moment, I am a single user managing multiple machines (I expect this to grow).

### Getting Started

To deploy a configuration, you can use the `nixos-rebuild` command with the appropriate flake output. For example, to deploy the `endgame` configuration on the local machine:

```bash
# To build the configuration
nixos-rebuild build --flake .#endgame

# To test the configuration
nixos-rebuild test --flake .#endgame

# To apply the configuration
sudo nixos-rebuild switch --flake .#endgame
```

To deploy to a remote machine over SSH, you can use the `--flake` and `--target-host` flags:

```bash
nixos-rebuild switch --flake .#endgame --target-host velen2077@endgame --use-remote-sudo
```

### Customization

To adapt this configuration for your own use, you'll need to create a new host and user.

1.  **Create a new host directory** in `nixos/hosts`. You can copy an existing one (e.g., `nixos/hosts/nixvm`) as a template.
2.  **Generate a new `hardware-configuration.nix`** on the target machine with `nixos-generate-config`.
3.  **Update your `flake.nix`** to add a new `nixosConfigurations` entry for your new host.
4.  **Create a new user directory** in `home/` and a corresponding entry in `nixos/config/users`.
4.  **Create a new host file** in `home/$USER` for the Home Manager config for that specific host and user.

### Updating

To update the flake inputs (e.g., `nixpkgs`), run the following command:

```bash
nix flake update
```
### Configuring Secure Boot

To enable Secure Boot for a host, there are a few manual steps that have to happen, focussed around generating encryption keys and enrolling them in to the UEFI firmware for Secure Boot.

1. Build the host with lanzaboote added as an optional config.
2. Run the following command to generate keys for the host:
   
```bash
sudo sbctl create-keys
```
3. Reboot the host and enter the UEFI firmware configuration.
4. Enable Secure Boot and make sure it is in 'Setup Mode'. For my MSI motherboard, there isn't a specifc 'Setup Mode' option. Instead, I select 'Factory Keys' = 'disabled' and 'Secure Boot Mode' = 'Custom'. After rebooting and entering the UEFI firmware again, I can then go in to the newly added custom option and select 'Delete all UEFI vars'.
5. Reboot the host again.
6. Run the following command:

```bash
sudo sbctl verify
```
7. Ensure there are verified signatures. They will appear with a green tick.
8. Run the following command to enroll the keys:

```bash
# --microsoft ensures that Microsoft keys are enrolled by default so that we can dual boot with Windows if needed.
sudo sbctl enroll-keys --microsoft
```
9. Reboot the host again and enter the UEFI firmware.
10. Change the Secure Boot mode to 'Standard' - effectively bringing it out of Setup Mode.
11. Save changes and reboot the host.
12. Verify Secure Boot is enabled by running the following command:
```bash
sudo sbctl status
```
13. You should see that Secure Boot is listed as enabled (user).

## Hosts

| System | Description | Type | OS | CPU | GPU |
|---|---|---|---|---|---|
| endgame | My personal desktop | Custom build | NixOS | AMD Ryzen 7800X3D | AMD 9070XT |
| nixvm | My test VM | QEMU VM | NixOS | Host passthrough | OpenGL/3D accelerated |

I have a single user that I manage through Home Manager (velen2077). You may add additional users or rename mine to inherit my existing settings - though don't forget to change my hashedPassword to something of your own otherwise you won't be able to log in.

### File structure

I use the following structure to organise my configurations.

```
.
├── flake.nix             # My flake. Entry point for system configs.
├── assets                # Stores additional items such as wallpapers and avatars.
│   ├── avatars           # User avatars/profile pictures.
│   ├── images            # Images used for this repo, such as logos.
│   └── wallpapers        # Wallpapers I used on my system that are used by Stylix.
├── home                  # Home folder that contains a folder for each Home Manager user.
│   └── velen2077         # My primary user, managed by Home Manager.
│       ├── global        # Global Home Manager configs, all imported and applied to the user.
│       └── features      # Optional Home Manager configs, selectively imported per user.
├── modules               # Modules folder, containing a subfolder for both NixOS and Home Manager.
│   ├── home-manager      # Custom-written and sharable Home Manager modules.
│   └── nixos             # Custom-written and sharable NixOS modules.
├── hosts                 # NixOS configs, containing a subfolder for each host and a config folder.
│   ├── common            # NixOS config files for system configs.
│   │   ├── core          # Global system configs, to apply on every system.
│   │   ├── optional      # Optional system configs, selectively imported per host.
│   │   └── users         # Optional user settings to apply on selected systems with options.
│   └── nixos             # NixOS hosts managed by megadots.
│       └── endgame       # The configuration for my primary desktop system.
│       └── nixvm         # The configuration for my test VM.
├── overlays              # Overlays folder containing any patches or overrides.
├── pkgs                  # Pkgs folder for storing any custom packaged apps.
```

## mega-thanks

I learn by doing. None of this would be possible without the copious ammounts of developers and repos that share their content freely for others like me to disect and study. There are many, but to name a few - shout outs go to:

[ryan4yin](https://github.com/ryan4yin/) for their [awesome book](https://nixos-and-flakes.thiscute.world/) on NixOS (if you haven't started here, then give it a whirl - it really was great) and the [i3 Kickstarter repo](https://github.com/ryan4yin/nix-config/blob/i3-kickstarter/). Both excellent resources to help me understand the power of NixOS.

The majority of my config structure was heavily influenced by the awesome [Misterio77](https://github.com/Misterio77/). Not only did his [Nix Starter Configs](https://github.com/Misterio77/nix-starter-configs) help guide me early on, but his own [Nix Config](https://github.com/Misterio77/nix-config/tree/main) repo was a great inspiration on how to construct and model a modular Nix configuration.

#### And more inspiration...

- Nvim - https://github.com/Nvim (https://github.com/Nvim/snowfall)
- mtrsk - https://github.com/mtrsk (https://github.com/mtrsk/nixos-config)
- runarsf - https://github.com/runarsf (https://github.com/runarsf/dotfiles)
- librephoenix - https://github.com/librephoenix (https://github.com/librephoenix/nixos-config)
- frost-phoenix - https://github.com/Frost-Phoenix (https://github.com/Frost-Phoenix/nixos-config)