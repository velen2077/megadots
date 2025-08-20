{
  inputs,
  cosmicLib,
  ...
}: {
  imports = [
    inputs.cosmic-manager.homeManagerModules.cosmic-manager
  ];
  xdg.configFile.cosmic-comp = {
    source = ./config.ron;
    target = "cosmic-comp/config.ron";
    recursive = true;
  };

  wayland.desktopManager.cosmic = {
    enable = true;
    configFile = {
      "com.system76.CosmicTheme.Dark.Builder" = {
        version = 1;
        entries = {
          active_hint = 0;
          gaps = cosmicLib.cosmic.mkRON "raw" "(0, 0)";
          accent = cosmicLib.cosmic.mkRON "optional" (cosmicLib.cosmic.mkRON "raw" "(\n    red: 0.7921569,\n    green: 0.7294118,\n    blue: 0.7058824,\n)");
        };
      };
      "com.system76.CosmicTheme.Light.Builder" = {
        version = 1;
        entries = {
          gaps = cosmicLib.cosmic.mkRON "raw" "(0, 0)";
          active_hint = 0;
        };
      };
      "com.system76.CosmicTheme.Light" = {
        version = 1;
        entries = {
          gaps = cosmicLib.cosmic.mkRON "raw" "(0, 0)";
          active_hint = 0;
        };
      };
      "com.system76.CosmicPanel" = {
        version = 1;
        entries = {
          entries = cosmicLib.cosmic.mkRON "raw" "[\n    \"Panel\",\n    \"Dock\",\n]";
        };
      };
      "com.system76.CosmicPanel.Panel" = {
        version = 1;
        entries = {
          exclusive_zone = true;
          plugins_center = cosmicLib.cosmic.mkRON "optional" (cosmicLib.cosmic.mkRON "raw" "[\n    \"com.system76.CosmicAppletTime\",\n]");
          autohide = cosmicLib.cosmic.mkRON "optional" null;
          margin = 0;
          expand_to_edges = true;
          size_wings = cosmicLib.cosmic.mkRON "optional" null;
          size = cosmicLib.cosmic.mkRON "raw" "XS";
          keyboard_interactivity = cosmicLib.cosmic.mkRON "raw" "OnDemand";
          anchor_gap = false;
          anchor = cosmicLib.cosmic.mkRON "raw" "Top";
          opacity = 1.0;
          spacing = 2;
          border_radius = 0;
          padding = 0;
          output = cosmicLib.cosmic.mkRON "raw" "All";
          plugins_wings = cosmicLib.cosmic.mkRON "optional" (cosmicLib.cosmic.mkRON "raw" "([\n    \"com.system76.CosmicPanelWorkspacesButton\",\n    \"com.system76.CosmicPanelAppButton\",\n], [\n    \"com.system76.CosmicAppletInputSources\",\n    \"com.system76.CosmicAppletStatusArea\",\n    \"com.system76.CosmicAppletTiling\",\n    \"com.system76.CosmicAppletAudio\",\n    \"com.system76.CosmicAppletNetwork\",\n    \"com.system76.CosmicAppletBattery\",\n    \"com.system76.CosmicAppletNotifications\",\n    \"com.system76.CosmicAppletBluetooth\",\n    \"com.system76.CosmicAppletPower\",\n])");
          background = cosmicLib.cosmic.mkRON "raw" "ThemeDefault";
          layer = cosmicLib.cosmic.mkRON "raw" "Top";
          name = "\"Panel\"";
          autohover_delay_ms = cosmicLib.cosmic.mkRON "optional" 500;
          size_center = cosmicLib.cosmic.mkRON "optional" null;
        };
      };
      "com.system76.CosmicAppList" = {
        version = 1;
        entries = {
          filter_top_levels = cosmicLib.cosmic.mkRON "optional" null;
          enable_drag_source = true;
          favorites = cosmicLib.cosmic.mkRON "raw" "[\n    \"firefox\",\n    \"com.system76.CosmicTerm\",\n]";
        };
      };
      "com.system76.CosmicAppletTime" = {
        version = 1;
        entries = {
          show_date_in_top_panel = true;
          military_time = true;
          first_day_of_week = 0;
        };
      };
      "com.system76.CosmicComp" = {
        version = 1;
        entries = {
          autotile_behavior = cosmicLib.cosmic.mkRON "raw" "PerWorkspace";
          xkb_config = cosmicLib.cosmic.mkRON "raw" "(\n    rules: \"\",\n    model: \"pc104\",\n    layout: \"eu\",\n    variant: \"\",\n    options: Some(\"terminate:ctrl_alt_bksp\"),\n    repeat_delay: 600,\n    repeat_rate: 25,\n)";
          autotile = true;
        };
      };
      "com.system76.CosmicPanel.Dock" = {
        version = 1;
        entries = {
          border_radius = 160;
          size_wings = cosmicLib.cosmic.mkRON "optional" null;
          output = cosmicLib.cosmic.mkRON "raw" "All";
          anchor_gap = true;
          anchor = cosmicLib.cosmic.mkRON "raw" "Bottom";
          autohover_delay_ms = cosmicLib.cosmic.mkRON "optional" 500;
          margin = 4;
          size = cosmicLib.cosmic.mkRON "raw" "XL";
          plugins_center = cosmicLib.cosmic.mkRON "optional" (cosmicLib.cosmic.mkRON "raw" "[\n    \"com.system76.CosmicAppList\",\n    \"com.system76.CosmicAppletMinimize\",\n]");
          autohide = cosmicLib.cosmic.mkRON "optional" (cosmicLib.cosmic.mkRON "raw" "(\n    wait_time: 500,\n    transition_time: 200,\n    handle_size: 2,\n)");
          layer = cosmicLib.cosmic.mkRON "raw" "Top";
          name = "\"Dock\"";
          plugins_wings = cosmicLib.cosmic.mkRON "optional" null;
          keyboard_interactivity = cosmicLib.cosmic.mkRON "raw" "OnDemand";
          size_center = cosmicLib.cosmic.mkRON "optional" null;
          exclusive_zone = false;
          spacing = 4;
          padding = 0;
          background = cosmicLib.cosmic.mkRON "raw" "ThemeDefault";
          opacity = 1.0;
          expand_to_edges = false;
        };
      };
      "com.system76.CosmicTheme.Dark" = {
        version = 1;
        entries = {
          background = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.105882354,\n        green: 0.105882354,\n        blue: 0.105882354,\n        alpha: 1.0,\n    ),\n    component: (\n        base: (\n            red: 0.18219745,\n            green: 0.18219745,\n            blue: 0.18219745,\n            alpha: 1.0,\n        ),\n        hover: (\n            red: 0.2639777,\n            green: 0.2639777,\n            blue: 0.26397765,\n            alpha: 1.0,\n        ),\n        pressed: (\n            red: 0.34575796,\n            green: 0.34575796,\n            blue: 0.34575787,\n            alpha: 1.0,\n        ),\n        selected: (\n            red: 0.2639777,\n            green: 0.2639777,\n            blue: 0.26397765,\n            alpha: 1.0,\n        ),\n        selected_text: (\n            red: 0.7921569,\n            green: 0.7294118,\n            blue: 0.7058824,\n            alpha: 1.0,\n        ),\n        focus: (\n            red: 0.7921569,\n            green: 0.7294118,\n            blue: 0.7058824,\n            alpha: 1.0,\n        ),\n        divider: (\n            red: 0.7532969,\n            green: 0.7532969,\n            blue: 0.75329685,\n            alpha: 0.2,\n        ),\n        on: (\n            red: 0.7532969,\n            green: 0.7532969,\n            blue: 0.75329685,\n            alpha: 1.0,\n        ),\n        disabled: (\n            red: 0.18219745,\n            green: 0.18219745,\n            blue: 0.18219745,\n            alpha: 1.0,\n        ),\n        on_disabled: (\n            red: 0.46774718,\n            green: 0.46774718,\n            blue: 0.46774715,\n            alpha: 1.0,\n        ),\n        border: (\n            red: 0.7432059,\n            green: 0.7432059,\n            blue: 0.7432056,\n            alpha: 1.0,\n        ),\n        disabled_border: (\n            red: 0.7432059,\n            green: 0.7432059,\n            blue: 0.7432056,\n            alpha: 0.5,\n        ),\n    ),\n    divider: (\n        red: 0.2662247,\n        green: 0.2662247,\n        blue: 0.2662247,\n        alpha: 1.0,\n    ),\n    on: (\n        red: 0.90759414,\n        green: 0.9075942,\n        blue: 0.90759414,\n        alpha: 1.0,\n    ),\n    small_widget: (\n        red: 0.15292805,\n        green: 0.15292814,\n        blue: 0.1529279,\n        alpha: 0.25,\n    ),\n)";
          active_hint = 0;
          primary = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.15292811,\n        green: 0.15292811,\n        blue: 0.15292808,\n        alpha: 1.0,\n    ),\n    component: (\n        base: (\n            red: 0.21220893,\n            green: 0.2122089,\n            blue: 0.2122089,\n            alpha: 1.0,\n        ),\n        hover: (\n            red: 0.29098803,\n            green: 0.290988,\n            blue: 0.29098797,\n            alpha: 1.0,\n        ),\n        pressed: (\n            red: 0.36976713,\n            green: 0.36976713,\n            blue: 0.36976704,\n            alpha: 1.0,\n        ),\n        selected: (\n            red: 0.29098803,\n            green: 0.290988,\n            blue: 0.29098797,\n            alpha: 1.0,\n        ),\n        selected_text: (\n            red: 0.7921569,\n            green: 0.7294118,\n            blue: 0.7058824,\n            alpha: 1.0,\n        ),\n        focus: (\n            red: 0.7921569,\n            green: 0.7294118,\n            blue: 0.7058824,\n            alpha: 1.0,\n        ),\n        divider: (\n            red: 0.7913618,\n            green: 0.7913618,\n            blue: 0.7913618,\n            alpha: 0.2,\n        ),\n        on: (\n            red: 0.7913618,\n            green: 0.7913618,\n            blue: 0.7913618,\n            alpha: 1.0,\n        ),\n        disabled: (\n            red: 0.21220893,\n            green: 0.2122089,\n            blue: 0.2122089,\n            alpha: 1.0,\n        ),\n        on_disabled: (\n            red: 0.5017854,\n            green: 0.50178534,\n            blue: 0.50178534,\n            alpha: 1.0,\n        ),\n        border: (\n            red: 0.7432059,\n            green: 0.7432059,\n            blue: 0.7432056,\n            alpha: 1.0,\n        ),\n        disabled_border: (\n            red: 0.7432059,\n            green: 0.7432059,\n            blue: 0.7432056,\n            alpha: 0.5,\n        ),\n    ),\n    divider: (\n        red: 0.31702772,\n        green: 0.31702772,\n        blue: 0.3170277,\n        alpha: 1.0,\n    ),\n    on: (\n        red: 0.97342616,\n        green: 0.97342616,\n        blue: 0.97342604,\n        alpha: 1.0,\n    ),\n    small_widget: (\n        red: 0.2021259,\n        green: 0.202126,\n        blue: 0.20212576,\n        alpha: 0.25,\n    ),\n)";
          link_button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    hover: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    pressed: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    selected: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 0.2,\n    ),\n    on: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    on_disabled: (\n        red: 0.39607844,\n        green: 0.3647059,\n        blue: 0.3529412,\n        alpha: 0.5,\n    ),\n    border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 0.5,\n    ),\n)";
          palette = cosmicLib.cosmic.mkRON "raw" "(\n    name: \"cosmic-dark\",\n    bright_red: (\n        red: 1.0,\n        green: 0.627451,\n        blue: 0.5647059,\n        alpha: 1.0,\n    ),\n    bright_green: (\n        red: 0.36862746,\n        green: 0.85882354,\n        blue: 0.54901963,\n        alpha: 1.0,\n    ),\n    bright_orange: (\n        red: 1.0,\n        green: 0.6392157,\n        blue: 0.49019608,\n        alpha: 1.0,\n    ),\n    gray_1: (\n        red: 0.105882354,\n        green: 0.105882354,\n        blue: 0.105882354,\n        alpha: 1.0,\n    ),\n    gray_2: (\n        red: 0.14901961,\n        green: 0.14901961,\n        blue: 0.14901961,\n        alpha: 1.0,\n    ),\n    neutral_0: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    neutral_1: (\n        red: 0.012919981,\n        green: 0.012920018,\n        blue: 0.012919932,\n        alpha: 1.0,\n    ),\n    neutral_2: (\n        red: 0.0861041,\n        green: 0.086104296,\n        blue: 0.08610401,\n        alpha: 1.0,\n    ),\n    neutral_3: (\n        red: 0.17923617,\n        green: 0.17923623,\n        blue: 0.179236,\n        alpha: 1.0,\n    ),\n    neutral_4: (\n        red: 0.28060424,\n        green: 0.28060427,\n        blue: 0.280604,\n        alpha: 1.0,\n    ),\n    neutral_5: (\n        red: 0.3885728,\n        green: 0.38857287,\n        blue: 0.3885726,\n        alpha: 1.0,\n    ),\n    neutral_6: (\n        red: 0.5021107,\n        green: 0.5021108,\n        blue: 0.50211054,\n        alpha: 1.0,\n    ),\n    neutral_7: (\n        red: 0.6204993,\n        green: 0.6204995,\n        blue: 0.6204992,\n        alpha: 1.0,\n    ),\n    neutral_8: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 1.0,\n    ),\n    neutral_9: (\n        red: 0.8698165,\n        green: 0.8698165,\n        blue: 0.8698162,\n        alpha: 1.0,\n    ),\n    neutral_10: (\n        red: 0.99999994,\n        green: 1.0,\n        blue: 0.9999996,\n        alpha: 1.0,\n    ),\n    accent_blue: (\n        red: 0.3882353,\n        green: 0.8156863,\n        blue: 0.8745098,\n        alpha: 1.0,\n    ),\n    accent_indigo: (\n        red: 0.6313726,\n        green: 0.7529412,\n        blue: 0.92156863,\n        alpha: 1.0,\n    ),\n    accent_purple: (\n        red: 0.90588236,\n        green: 0.6117647,\n        blue: 0.99607843,\n        alpha: 1.0,\n    ),\n    accent_pink: (\n        red: 1.0,\n        green: 0.6117647,\n        blue: 0.69411767,\n        alpha: 1.0,\n    ),\n    accent_red: (\n        red: 0.99215686,\n        green: 0.6313726,\n        blue: 0.627451,\n        alpha: 1.0,\n    ),\n    accent_orange: (\n        red: 1.0,\n        green: 0.6784314,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    accent_yellow: (\n        red: 0.96862745,\n        green: 0.8784314,\n        blue: 0.38431373,\n        alpha: 1.0,\n    ),\n    accent_green: (\n        red: 0.57254905,\n        green: 0.8117647,\n        blue: 0.6117647,\n        alpha: 1.0,\n    ),\n    accent_warm_grey: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    ext_warm_grey: (\n        red: 0.60784316,\n        green: 0.5568628,\n        blue: 0.5411765,\n        alpha: 1.0,\n    ),\n    ext_orange: (\n        red: 1.0,\n        green: 0.6784314,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    ext_yellow: (\n        red: 0.99607843,\n        green: 0.85882354,\n        blue: 0.2509804,\n        alpha: 1.0,\n    ),\n    ext_blue: (\n        red: 0.28235295,\n        green: 0.7254902,\n        blue: 0.78039217,\n        alpha: 1.0,\n    ),\n    ext_purple: (\n        red: 0.8117647,\n        green: 0.49019608,\n        blue: 1.0,\n        alpha: 1.0,\n    ),\n    ext_pink: (\n        red: 0.9764706,\n        green: 0.22745098,\n        blue: 0.5137255,\n        alpha: 1.0,\n    ),\n    ext_indigo: (\n        red: 0.24313726,\n        green: 0.53333336,\n        blue: 1.0,\n        alpha: 1.0,\n    ),\n)";
          icon_button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    hover: (\n        red: 0.3885728,\n        green: 0.38857287,\n        blue: 0.3885726,\n        alpha: 0.2,\n    ),\n    pressed: (\n        red: 0.0861041,\n        green: 0.086104296,\n        blue: 0.08610401,\n        alpha: 0.5,\n    ),\n    selected: (\n        red: 0.3885728,\n        green: 0.38857287,\n        blue: 0.3885726,\n        alpha: 0.2,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 0.2,\n    ),\n    on: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    on_disabled: (\n        red: 0.37160295,\n        green: 0.37160295,\n        blue: 0.3716028,\n        alpha: 0.5,\n    ),\n    border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 0.5,\n    ),\n)";
          accent = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.7114401,\n        green: 0.661244,\n        blue: 0.6424204,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.43913049,\n        green: 0.40775803,\n        blue: 0.3959932,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.7114401,\n        green: 0.661244,\n        blue: 0.6424204,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: 0.39607844,\n        green: 0.3647059,\n        blue: 0.3529412,\n        alpha: 1.0,\n    ),\n    border: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 0.5,\n    ),\n)";
          destructive_button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.8777146,\n        green: 0.6455577,\n        blue: 0.64555764,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.5430521,\n        green: 0.3979541,\n        blue: 0.397954,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.8777146,\n        green: 0.6455577,\n        blue: 0.64555764,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.012919981,\n        green: 0.012920018,\n        blue: 0.012919932,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.5,\n    ),\n    border: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 0.5,\n    ),\n)";
          accent_button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.7114401,\n        green: 0.661244,\n        blue: 0.6424204,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.43913049,\n        green: 0.40775803,\n        blue: 0.3959932,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.7114401,\n        green: 0.661244,\n        blue: 0.6424204,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.012919981,\n        green: 0.012920018,\n        blue: 0.012919932,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.5,\n    ),\n    border: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 0.5,\n    ),\n)";
          secondary = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.20212594,\n        green: 0.20212597,\n        blue: 0.20212597,\n        alpha: 1.0,\n    ),\n    component: (\n        base: (\n            red: 0.23260304,\n            green: 0.23260307,\n            blue: 0.23260304,\n            alpha: 1.0,\n        ),\n        hover: (\n            red: 0.30934274,\n            green: 0.30934277,\n            blue: 0.30934268,\n            alpha: 1.0,\n        ),\n        pressed: (\n            red: 0.3860824,\n            green: 0.38608247,\n            blue: 0.38608235,\n            alpha: 1.0,\n        ),\n        selected: (\n            red: 0.30934274,\n            green: 0.30934277,\n            blue: 0.30934268,\n            alpha: 1.0,\n        ),\n        selected_text: (\n            red: 0.7921569,\n            green: 0.7294118,\n            blue: 0.7058824,\n            alpha: 1.0,\n        ),\n        focus: (\n            red: 0.7921569,\n            green: 0.7294118,\n            blue: 0.7058824,\n            alpha: 1.0,\n        ),\n        divider: (\n            red: 0.81693083,\n            green: 0.8169309,\n            blue: 0.8169309,\n            alpha: 0.2,\n        ),\n        on: (\n            red: 0.81693083,\n            green: 0.8169309,\n            blue: 0.8169309,\n            alpha: 1.0,\n        ),\n        disabled: (\n            red: 0.23260304,\n            green: 0.23260307,\n            blue: 0.23260304,\n            alpha: 1.0,\n        ),\n        on_disabled: (\n            red: 0.5247669,\n            green: 0.524767,\n            blue: 0.524767,\n            alpha: 1.0,\n        ),\n        border: (\n            red: 0.7432059,\n            green: 0.7432059,\n            blue: 0.7432056,\n            alpha: 1.0,\n        ),\n        disabled_border: (\n            red: 0.7432059,\n            green: 0.7432059,\n            blue: 0.7432056,\n            alpha: 0.5,\n        ),\n    ),\n    divider: (\n        red: 0.3174277,\n        green: 0.31742772,\n        blue: 0.3174277,\n        alpha: 1.0,\n    ),\n    on: (\n        red: 0.7786347,\n        green: 0.7786347,\n        blue: 0.77863467,\n        alpha: 1.0,\n    ),\n    small_widget: (\n        red: 0.25329077,\n        green: 0.2532909,\n        blue: 0.25329062,\n        alpha: 0.25,\n    ),\n)";
          button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.6204993,\n        green: 0.6204995,\n        blue: 0.6204992,\n        alpha: 0.25,\n    ),\n    hover: (\n        red: 0.38796422,\n        green: 0.3879643,\n        blue: 0.38796413,\n        alpha: 0.4,\n    ),\n    pressed: (\n        red: 0.16715191,\n        green: 0.16715205,\n        blue: 0.16715184,\n        alpha: 0.625,\n    ),\n    selected: (\n        red: 0.38796422,\n        green: 0.3879643,\n        blue: 0.38796413,\n        alpha: 0.4,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.7532969,\n        green: 0.7532969,\n        blue: 0.75329685,\n        alpha: 0.2,\n    ),\n    on: (\n        red: 0.7532969,\n        green: 0.7532969,\n        blue: 0.75329685,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.47242564,\n        green: 0.47242576,\n        blue: 0.47242552,\n        alpha: 0.34375,\n    ),\n    on_disabled: (\n        red: 0.50074834,\n        green: 0.50074834,\n        blue: 0.5007483,\n        alpha: 0.625,\n    ),\n    border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 0.5,\n    ),\n)";
          warning = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.8777146,\n        green: 0.833793,\n        blue: 0.5734008,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.5430521,\n        green: 0.51560116,\n        blue: 0.35285595,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.8777146,\n        green: 0.833793,\n        blue: 0.5734008,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: 0.5,\n        green: 0.47254902,\n        blue: 0.30980393,\n        alpha: 1.0,\n    ),\n    border: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 0.5,\n    ),\n)";
          warning_button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.8777146,\n        green: 0.833793,\n        blue: 0.5734008,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.5430521,\n        green: 0.51560116,\n        blue: 0.35285595,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.8777146,\n        green: 0.833793,\n        blue: 0.5734008,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.99999994,\n        green: 1.0,\n        blue: 0.9999996,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.5,\n    ),\n    border: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 1.0,\n        green: 0.94509804,\n        blue: 0.61960787,\n        alpha: 0.5,\n    ),\n)";
          destructive = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.8777146,\n        green: 0.6455577,\n        blue: 0.64555764,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.5430521,\n        green: 0.3979541,\n        blue: 0.397954,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.8777146,\n        green: 0.6455577,\n        blue: 0.64555764,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: 0.5,\n        green: 0.35490197,\n        blue: 0.35490197,\n        alpha: 1.0,\n    ),\n    border: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 1.0,\n        green: 0.70980394,\n        blue: 0.70980394,\n        alpha: 0.5,\n    ),\n)";
          success = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.6745098,\n        green: 0.96862745,\n        blue: 0.8235294,\n        alpha: 1.0,\n    ),\n    hover: (\n        red: 0.61732244,\n        green: 0.85261655,\n        blue: 0.73653805,\n        alpha: 1.0,\n    ),\n    pressed: (\n        red: 0.38030696,\n        green: 0.52736586,\n        blue: 0.45481673,\n        alpha: 1.0,\n    ),\n    selected: (\n        red: 0.61732244,\n        green: 0.85261655,\n        blue: 0.73653805,\n        alpha: 1.0,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    on: (\n        red: -0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.6745098,\n        green: 0.96862745,\n        blue: 0.8235294,\n        alpha: 1.0,\n    ),\n    on_disabled: (\n        red: 0.3372549,\n        green: 0.48431373,\n        blue: 0.4117647,\n        alpha: 1.0,\n    ),\n    border: (\n        red: 0.6745098,\n        green: 0.96862745,\n        blue: 0.8235294,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.6745098,\n        green: 0.96862745,\n        blue: 0.8235294,\n        alpha: 0.5,\n    ),\n)";
          gaps = cosmicLib.cosmic.mkRON "raw" "(0, 0)";
          text_button = cosmicLib.cosmic.mkRON "raw" "(\n    base: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    hover: (\n        red: 0.3885728,\n        green: 0.38857287,\n        blue: 0.3885726,\n        alpha: 0.2,\n    ),\n    pressed: (\n        red: 0.0861041,\n        green: 0.086104296,\n        blue: 0.08610401,\n        alpha: 0.5,\n    ),\n    selected: (\n        red: 0.3885728,\n        green: 0.38857287,\n        blue: 0.3885726,\n        alpha: 0.2,\n    ),\n    selected_text: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    focus: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    divider: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 0.2,\n    ),\n    on: (\n        red: 0.7921569,\n        green: 0.7294118,\n        blue: 0.7058824,\n        alpha: 1.0,\n    ),\n    disabled: (\n        red: 0.0,\n        green: 0.0,\n        blue: 0.0,\n        alpha: 0.0,\n    ),\n    on_disabled: (\n        red: 0.39607844,\n        green: 0.3647059,\n        blue: 0.3529412,\n        alpha: 0.5,\n    ),\n    border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 1.0,\n    ),\n    disabled_border: (\n        red: 0.7432059,\n        green: 0.7432059,\n        blue: 0.7432056,\n        alpha: 0.5,\n    ),\n)";
        };
      };
      "com.system76.CosmicBackground" = {
        version = 1;
        entries = {
          all = cosmicLib.cosmic.mkRON "raw" "(\n    output: \"all\",\n    source: Path(\"/run/current-system/sw/share/backgrounds/cosmic/phytoplankton_bloom_nasa_oli2_20240121.jpg\"),\n    filter_by_theme: true,\n    rotation_frequency: 300,\n    filter_method: Lanczos,\n    scaling_mode: Zoom,\n    sampling_method: Alphanumeric,\n)";
          same-on-all = true;
        };
      };
    };
    stateFile = {
      "com.system76.CosmicSettings" = {
        version = 1;
        entries = {
          active_page = "\"wallpaper\"";
        };
      };
      "com.system76.CosmicBackground" = {
        version = 1;
        entries = {
          wallpapers = cosmicLib.cosmic.mkRON "raw" "[\n    (\"HDMI-A-1\", Path(\"/nix/store/49x5q2v3qd96zjnsi8l4jidw08xfh37i-cosmic-wallpapers-1.0.0-alpha.7/share/backgrounds/cosmic/phytoplankton_bloom_nasa_oli2_20240121.jpg\")),\n]";
        };
      };
      "com.system76.CosmicSettingsDaemon" = {
        version = 1;
        entries = {
          default_sink_name = "\"@DEFAULT_SINK@\"";
        };
      };
    };
  };
}
