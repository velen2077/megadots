{
  config,
  lib,
  pkgs,
  inputs,
  cosmicLib,
  ...
}: {
  wayland.desktopManager.cosmic.compositor = {
    workspaces = {
      workspace_layout = cosmicLib.cosmic.mkRON "enum" "Vertical";
      workspace_mode = cosmicLib.cosmic.mkRON "enum" "OutputBound";
    };
    xkb_config = {
      layout = "gb";
      model = "pc104";
      options = cosmicLib.cosmic.mkRON "optional" "terminate:ctrl_alt_bksp";
      repeat_delay = 600;
      repeat_rate = 25;
      rules = "";
      variant = "extd";
    };
  };
}
