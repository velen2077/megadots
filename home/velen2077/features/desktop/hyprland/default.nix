{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hypridle/hypridle.nix
    ./hyprlock/hyprlock.nix
    ./hyprpaper/hyprpaper.nix
    ./mako/mako.nix
    ./rofi/rofi.nix
    ./scripts/scripts.nix
    ./waybar/waybar.nix
  ];

  home.packages = with pkgs; [hyprpolkitagent];

  wayland.windowManager.hyprland = {
    enable = true;

    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    systemd.variables = ["--all"];

    settings = {
      # Variables
      "$mod" = "SUPER";
      "$left" = "LEFT";
      "$down" = "DOWN";
      "$up" = "UP";
      "$right" = "RIGHT";
      "$terminal" = "alacritty";
      "$menu" = "rofi";

      # Monitor configuration
      monitor = [
        #",highrr,auto,1"
        ",2560x1440@60,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      device = {
        name = "asuf1205:00-2808:0106-touchpad";
        accel_profile = "adaptive";
      };

      # Input configuration
      input = {
        accel_profile = "flat";
        sensitivity = 0;
        follow_mouse = 1;
        kb_layout = "gb";

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
          middle_button_emulation = false;
          tap-and-drag = true;
          drag_lock = false;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
      };

      # General settings
      general = {
        gaps_in = config.theme.spacing.xs;
        gaps_out = config.theme.spacing.xs;
        border_size = config.theme.borderWidth;
        layout = "dwindle";
        allow_tearing = false;

        "col.active_border" = lib.mkForce "rgb(${config.theme.colors.base08})";
        "col.inactive_border" = lib.mkForce "rgb(${config.theme.colors.base03})";
      };

      # Decoration
      decoration = {
        rounding = config.theme.borderRadius;
        active_opacity = 1.0;
        inactive_opacity = toString config.theme.opacity;

        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      # Animations
      animations = {
        enabled = false;
      };

      # Group configuration
      group = {
        groupbar = {
          enabled = false;
          stacked = false;
        };
        "col.border_active" = lib.mkForce "rgb(${config.theme.colors.base03})";
        "col.border_inactive" = lib.mkForce "rgb(${config.theme.colors.base01})";
      };

      # Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 2; # adaptive sync
      };

      # Window rules
      windowrule = [
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(nemo)$"
        "size 800 600, class:^(org.pulseaudio.pavucontrol)$"
        "opacity ${toString config.theme.opacity} ${toString config.theme.opacity}, floating:1"
      ];

      layerrule = [
        "blur, rofi"
      ];

      # Key bindings
      bind = [
        # Basic bindings
        "$mod, RETURN, exec, $terminal"
        "$mod, q, killactive"
        "$mod, d, exec, $menu -show drun"
        "$mod, p, exec, $menu -show powermenu"
        "$mod, F11, exec, hyprctl reload"
        "$mod, TAB, workspace, previous"

        # Movement
        "$mod, $left, movefocus, l"
        "$mod, $down, movefocus, d"
        "$mod, $up, movefocus, u"
        "$mod, $right, movefocus, r"

        "$mod SHIFT, $left, movewindow, l"
        "$mod SHIFT, $down, movewindow, d"
        "$mod SHIFT, $up, movewindow, u"
        "$mod SHIFT, $right, movewindow, r"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move container to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Layout bindings
        "$mod, SLASH, layoutmsg, togglesplit"
        #"$mod, COMMA, exec, bash ${../../../../assets/scripts/hypr-group.sh}"
        "$mod, j, changegroupactive, b"
        "$mod, k, changegroupactive, f"
        "$mod CTRL, F, fullscreen"
        "$mod, APOSTROPHE, exec, hyprctl --batch \"dispatch togglefloating; dispatch resizeactive exact 1000 800; dispatch centerwindow 1\""
        "$mod, SPACE, focusurgentorlast"

        # Scratchpad (special workspace)
        "$mod, BRACKETRIGHT, movetoworkspace, special"
        "$mod, BRACKETLEFT, togglespecialworkspace"
        "$mod, BACKSLASH, togglefloating"

        # Resizing
        "$mod, MINUS, resizeactive, -50 0"
        "$mod, EQUAL, resizeactive, 50 0"
        "$mod SHIFT, MINUS, resizeactive, 0 -50"
        "$mod SHIFT, EQUAL, resizeactive, 0 50"

        # Monitor movement
        "$mod SHIFT, RIGHT, movewindow, mon:+1"
        "$mod SHIFT, LEFT, movewindow, mon:-1"
        "$mod SHIFT, UP, movewindow, mon:+1"
        "$mod SHIFT, DOWN, movewindow, mon:-1"

        # Screenshots
        ", PRINT, exec, grim"
        "ALT SHIFT, 4, exec, grim -g \"$(slurp)\" ${config.home.homeDirectory}/Pictures/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys
      bindl = [
        #", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ${../../../../assets/scripts/volume-notify.sh}"
        #", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && ${../../../../assets/scripts/volume-notify.sh}"
        #", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ && ${../../../../assets/scripts/volume-notify.sh}"
        #", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${../../../../assets/scripts/volume-notify.sh}"
        #", XF86MonBrightnessDown, exec, brightnessctl set 5%- && ${../../../../assets/scripts/brightness-notify.sh}"
        #", XF86MonBrightnessUp, exec, brightnessctl set 5%+ && ${../../../../assets/scripts/brightness-notify.sh}"

        #", switch:on:Lid Switch, exec, hyprlock & systemctl suspend"
      ];

      # Mouse wheel workspace switching
      binde = [
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Startup applications
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "waybar"
        "nm-applet"
      ];

      # Environment variables
      env = [
        "XCURSOR_SIZE,16"
      ];
    };
  };
}
