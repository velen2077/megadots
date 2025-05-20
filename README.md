<p align="center">
  <img src="assets/images/megadots.png" alt="megadots by velen2077"/>
</p>

# megadots

My modular and Flaked-out repo for managing my systems using Nix, Flakes and Home Manager (as a NixOS module). I publish megadots to help others, as I found Github and other peoples repos (some shoutouts below!) extremely helpful to learn Nix/NixOS. Hopefully I can return the favour by publishing my own, for others to use, adapt, and learn.

> **Note:** Though I use this repo for my own config, I also dabble and break things from time to time. I tend to keep working code in the `main` branch. Any other branch, assume it is a work in progress and not suitable for use. Also note that as this is my primary personal config, my `hardware-configuration.nix` files and attributes like `hostname`, `hashedPassword` and `username` will be unique to me, so you'll have to bring your own.

## Introduction

This is my personal system configuration repo that I use to build systems and homes in conjunction with Nix, Home Manager and Flakes. I started out this journey based on sheer curiosity and a desire to have a somewhat declaritive composition to system management (I distro hop - a lot). Some searching online lead me down the garden path that is Nix, and here I am. Down the rabbit hole.

I am not an expert in Nix, NixOS, Home Manager or Flakes. Nor am I a developer. Outside of my consultancy job (in a technical field so not completely in the dark), I'm a tinkerer. I'd been feeling a little burnt out and in need of something to learn in my downtime, and this project came along at the perfect time, and has genuinely brought some fun back in to computing for me. Just like the days of old, going to the local monthly computer market and picking up a fresh copy of a new Linux distro on a wad of floppies and taking it for a spin.

## Features
- **NixOS** system configuration on mulitple hosts.
- **Home Manager** user configuration for my user.
- **Impermanence** with LUKS encrypted btrfs snapshot and rollback.#
- **Flakes** and modular configs.
- **Disko** for disk partioning and preperation.
- **Chaotic** inputs for CachyOS kernel.

## Usage

This configuration has a multiple system entry points, with Home Manager configured as a NixOS module. At the moment, I am a single user managing multiple machines (I expect this to grow).

| System | Description | Type | OS | CPU | GPU |
|---|---|---|---|---|---|
| endgame | My personal desktop | Custom build | NixOS | AMD Ryzen 7800X3D | AMD 9070XT |
| flatmate | My personal laptop | Microsoft Surface Pro 7 | NixOS | Intel Core i7-1065G7 | Intel Iris Plus G7 |
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
│       ├── core          # Core Home Manager modules, all imported and applied to the user.
│       └── optional      # Optional Home Manager modules, all imported and toggled with options.
├── modules               # Modules folder, containing a subfolder for both NixOS and Home Manager.
│   ├── home-manager      # Custom-written and sharable Home Manager modules.
│   └── nixos             # Custom-written and sharable NixOS modules.
├── nixos                 # NixOS configs, containing a subfolder for each host and a config folder.
│   ├── config            # NixOS config files for system configs.
│   │   ├── core          # Core system configs, to apply on every system.
│   │   ├── optional      # Optional system configs, all imported, and toggled with options.
│   │   └── users         # Optional user settings to apply on selected systems with options.
│   └── endgame           # The configuration for my primary desktop system.
│   └── flatmate          # The configuration for my primary laptop system.
│   └── nixvm             # The configuration for my test VM.
├── overlays              # Overlays folder containing any patches or overrides.
├── pkgs                  # Pkgs folder for storing any custom packaged apps.
```

## mega-thanks

I learn by doing. None of this would be possible without the copious ammounts of developers and repos that share their content freely for others like me to disect and study. There are many, but to name a few - shout outs go to:

[ryan4yin](https://github.com/ryan4yin/) for their [awesome book](https://nixos-and-flakes.thiscute.world/) on NixOS (if you haven't started here, then give it a whirl - it really was great) and the [i3 Kickstarter repo](https://github.com/ryan4yin/nix-config/blob/i3-kickstarter/). Both excellent resources to help me understand the power of NixOS.

The majority of my config structure was heavily influenced by the awesome [Misterio77](https://github.com/Misterio77/). Not only did he's [Nix Starter Configs](https://github.com/Misterio77/nix-starter-configs) help guide me early on, but his own [Nix Config](https://github.com/Misterio77/nix-config/tree/main) repo was a great inspiration on how to construct and model a modular Nix configuration.

#### And more inspiration...

- Nvim - https://github.com/Nvim (https://github.com/Nvim/snowfall)
- mtrsk - https://github.com/mtrsk (https://github.com/mtrsk/nixos-config)
- runarsf - https://github.com/runarsf (https://github.com/runarsf/dotfiles)
- librephoenix - https://github.com/librephoenix (https://github.com/librephoenix/nixos-config)
- frost-phoenix - https://github.com/Frost-Phoenix (https://github.com/Frost-Phoenix/nixos-config)