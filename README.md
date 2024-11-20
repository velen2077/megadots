# megadots

My modular and Flaked-out repo for managing systems using Nix, Flakes and Home Manager (as a system module). I publish megadots to help others, as I found Github and other peoples repos (some shoutouts below!) extremely helpful to learn Nix/NixOS. Hopefully I can return the favour by publishing my own, for others to use, adapt, and learn.

## Standard disclaimer

Though I use this repo for my own config, I also dabble and break things from time to time. I tend to keep working code in the `main` branch. Any other branch, assume it is a work in progress and not suitable for application. Also note that as this is my primary personal config, my `hardware-configuration.nix` and attributes like `hostname`, `hashedPassword` and `username` will be unique to me, so you'll have to bring your own.

## Introduction

This is my personal system configuration repo that I use to build systems and homes in conjunction with Nix, Home Manager and Flakes. I started out this journey based on sheer curiosity and a desire to have a somewhat declaritive composition to system management (I distro hop - a lot). Some searching online lead me down the garden path that is Nix, and here I am. Down the rabbit hole.

I am not an expert in Nix, NixOS, Home Manager or Flakes. Nor am I a developer. Outside of my consultancy job (in a technical field so not completely in the dark), I'm a tinkerer. I'd been feeling a little burnt out and in need of something to learn in my downtime, and this project came along at the perfect time, and has genuinely brought some fun back in to computing for me. Just like the days of old, going to the local monthly computer market and picking up a fresh copy of a new Linux distro on a wad of floppies and taking it for a spin.

## Usage

This configuration has a single system entry point, with Home Manager configured as a system module. At the moment, I am a single user managing a single machine (though expect this to grow).

| System | Description | OS | CPU | GPU |
|---|---|---|---|---|
| endgame | My personal computer | NixOS | AMD Ryzen 7800X3D | nVidia 4070 Ti |

I have a single user that I manage through Home Manager (velen2077). You may add additional users or rename mine to inherit my existing settings - though don't forget to change my hashedPassword to something of your own otherwise you won't be able to log in.

### File structure

```
Update coming soon(tm).
```

## mega-thanks

I learn by doing. None of this would be possible without the copious ammounts of developers and repos that share their content freely for others like me to disect and study. There are many, but to name a few - shout outs go to:

[ryan4yin](https://github.com/ryan4yin/) for their [awesome book](https://nixos-and-flakes.thiscute.world/) on NixOS (if you haven't started here, then give it a whirl - it really was great) and the [i3 Kickstarter repo](https://github.com/ryan4yin/nix-config/blob/i3-kickstarter/). Both excellent resources to help me understand the power of NixOS.

#### And more inspiration...

- Nvim - https://github.com/Nvim (https://github.com/Nvim/snowfall)
- mtrsk - https://github.com/mtrsk (https://github.com/mtrsk/nixos-config)
- runarsf - https://github.com/runarsf (https://github.com/runarsf/dotfiles)
- librephoenix - https://github.com/librephoenix (https://github.com/librephoenix/nixos-config)
- frost-phoenix - https://github.com/Frost-Phoenix (https://github.com/Frost-Phoenix/nixos-config)

[Ryan]: Ryan4yin