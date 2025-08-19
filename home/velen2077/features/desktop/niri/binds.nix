{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Quickshell Keybinds Start
    "super+Control+Return".action = spawn ["qs" "ipc" "call" "globalIPC" "toggleLauncher"];
    # Quickshell Keybinds End

    #"xf86audioraisevolume".action = volume-up;
    #"xf86audiolowervolume".action = volume-down;

    "control+super+xf86audioraisevolume".action = spawn "brightness" "up";
    "control+super+xf86audiolowervolume".action = spawn "brightness" "down";

    "super+q".action = close-window;
    "super+b".action = spawn "firefox";
    "super+Return".action = spawn "kitty";
    #"super+Control+Return".action = spawn apps.appLauncher;
    "super+E".action = spawn "nemo";

    "super+f".action = fullscreen-window;
    "super+t".action = toggle-window-floating;

    "control+shift+1".action = screenshot;
    "control+shift+2".action = screenshot-window {write-to-disk = true;};

    "super+Left".action = focus-column-left;
    "super+Right".action = focus-column-right;
    "super+Down".action = focus-workspace-down;
    "super+Up".action = focus-workspace-up;

    "super+Shift+Left".action = move-column-left;
    "super+Shift+Right".action = move-column-right;
    "super+Shift+Down".action = move-column-to-workspace-down;
    "super+Shift+Up".action = move-column-to-workspace-up;

    "super+1".action = focus-workspace "web";
    "super+2".action = focus-workspace "code";
  };
}
