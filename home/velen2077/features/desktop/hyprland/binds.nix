{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    # Mouse bindings.
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, pulsemixer --change-volume +2"
      ", XF86AudioLowerVolume, exec, pulsemixer --change-volume -2"
      ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      "$mod ALT, k, exec, pulsemixer --change-volume +5"
      "$mod ALT, j, exec, pulsemixer --change-volume -5"
    ];

    bind = [
      "$mod,1,workspace,1"
      "$mod,2,workspace,2"
      "$mod,3,workspace,3"
      "$mod,4,workspace,4"
      "$mod,5,workspace,5"
      "$mod,6,workspace,6"
      "$mod,7,workspace,7"
      "$mod,8,workspace,8"
      "$mod,9,workspace,9"
      #"$mod,3,workspace,3,name:virt"
      #"$mod,4,workspace,4,name:chat"
      #"$mod,5,workspace,5,name:game"
      #"$mod,6,workspace,6,name:music"
      #"$mod,7,workspace,7"
      #"$mod,8,workspace,8"
      #"$mod,9,workspace,9"
      #"$mod,0,workspace,10"
      #"$mod,b,workspace,name:Music"
      #"$mod,t,workspace,name:Messengers"
      #"$mod,g,workspace,name:Games"

      # Window/Session actions.
      "$mod, Q, killactive,"
      "$mod, W, fullscreen, 1"
      "$mode SHIFT, W, fullscreen,"
      "$mod, F, togglefloating,"
      "$mod, delete, exit,"

      # Dwindle
      "$mod, O, togglesplit,"
      "$mod, P, pseudo,"

      "$mod, L, exec, hyprlock"
      "$mod, D, exec, rofi -show drun"
      "$mod, P, exec, rofi -show powermenu"

      # Application shortcuts.
      "$mod, Return, exec, alacritty"
      "$mod SHIFT, Return, exec, alacritty --class floating"

      # Special workspace
      "$mod, S, togglespecialworkspace"
      "$mod SHIFT, S, movetoworkspacesilent, special"

      # Launcher
      # "$mod, A, exec, rofi -show drun -kb-cancel Super_L"
      "$mod SHIFT, A, exec, ags -t launcher"

      # Screenshot
      "$mod SHIFT, z, exec, wl-copy < $(grimshot --notify save area $XDG_PICTURES_DIR/Screenshots/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png'))"

      # Move window focus with vim keys.
      "$mod, LEFT, movefocus, l"
      "$mod, RIGHT, movefocus, r"
      "$mod, UP, movefocus, u"
      "$mod, DOWN, movefocus, d"

      # Music control
      "$mod ALT, m, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
      ", XF86AudioMicMute, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
      ",XF86AudioMute, exec, pulsemixer --id $(pulsemixer --list-sinks | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
      "$mod ALT, l, exec, hyprmusic next"
      ",XF86AudioNext, exec, hyprmusic next"
      "$mod ALT, h, exec, hyprmusic previous"
      ", XF86AudioPrev, exec, hyprmusic previous"
      "$mod ALT, p, exec, hyprmusic play-pause"
      ", XF86AudioPlay, exec, hyprmusic play-pause"

      # Swap windows with vim keys
      "$mod SHIFT, LEFT, movewindow, l"
      "$mod SHIFT, RIGHT, movewindow, r"
      "$mod SHIFT, UP, movewindow, u"
      "$mod SHIFT, DOWN, movewindow, d"

      "$mod SHIFT, c, centerwindow, 1"

      # Move monitor focus.
      "$mod, TAB, focusmonitor, +1"

      "$mod CTRL, h, workspace, r-1"
      "$mod, Left, workspace, r-1"
      "$mod CTRL, l, workspace, r+1"
      "$mod, Right, workspace, r+1"

      # Scroll through monitor workspaces with mod + scroll
      "$mod, mouse_down, workspace, r-1"
      "$mod, mouse_up, workspace, r+1"
      "$mod, mouse:274, killactive,"

      # Move active window to a workspace.
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      "$mod CTRL SHIFT, l, movetoworkspace, r+1"
      "$mod SHIFT, Right, movetoworkspace, r+1"
      "$mod CTRL SHIFT, h, movetoworkspace, r-1"
      "$mod SHIFT, Left, movetoworkspace, r-1"
    ];
  };
  wayland.windowManager.hyprland.extraConfig = ''
    # will switch to a submap called resize
    bind=$mod,R,exec,echo -n "Resize" > /tmp/hypr_submap
    bind=$mod,R,submap,resize

    # will start a submap called "resize"
    submap=resize

    # sets repeatable binds for resizing the active window
    binde=,l,resizeactive,30 0
    binde=,h,resizeactive,-30 0
    binde=,k,resizeactive,0 -30
    binde=,j,resizeactive,0 30

    # use reset to go back to the global submap
    bind=,escape,exec,truncate -s 0 /tmp/hypr_submap
    bind=,escape,submap,reset

    # will reset the submap, meaning end the current one and return to the global one
    submap=reset

    bind=$mod,A,exec,echo -n "Launch" > /tmp/hypr_submap
    bind=$mod,A,submap,launch

    submap=launch
    bind=,F,exec,firefox
    bind=,D,exec,neovide --no-vsync

    bind=,escape,exec,truncate -s 0 /tmp/hypr_submap
    bind=,escape,submap,reset

    # Note, that after launching app submap immediately exits.
    bind=,F,exec,truncate -s 0 /tmp/hypr_submap
    bind=,F,submap,reset
    bind=,D,exec,truncate -s 0 /tmp/hypr_submap
    bind=,D,submap,reset

    # will reset the submap, meaning end the current one and return to the global one
    submap=reset
  '';
}
