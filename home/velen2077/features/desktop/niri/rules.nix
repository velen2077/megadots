{...}: let
  workspaces = {
    "01-web" = {name = "web";};
    "02-code" = {name = "code";};
    "03-virt" = {name = "virt";};
    "04-chat" = {name = "chat";};
    "05-music" = {name = "music";};
    "05-gaming" = {name = "gaming";};
  };
  windowRules = [
    {
      draw-border-with-background = false;
      geometry-corner-radius = let
        r = 5.0;
      in {
        top-left = r;
        top-right = r;
        bottom-left = r;
        bottom-right = r;
      };
      clip-to-geometry = true;
    }
    {
      matches = [
        {
          app-id = "^firefox$";
        }
      ];
      open-maximized = true;
      open-on-workspace = "web";
    }
    {
      matches = [
        {
          app-id = "^codium$";
        }
      ];
      open-maximized = true;
      open-on-workspace = "code";
    }
    {
      matches = [
        {
          app-id = "^virt-manager$";
        }
      ];
      open-on-workspace = "virt";
    }
    {
      matches = [
        {
          app-id = "^vesktop$";
        }
      ];
      open-maximized = true;
      open-on-workspace = "chat";
    }
    {
      matches = [
        {
          app-id = "^spotify$";
        }
      ];
      open-maximized = true;
      open-on-workspace = "music";
    }
    {
      matches = [
        {
          app-id = "^steam$";
        }
      ];
      open-maximized = true;
      open-on-workspace = "gaming";
    }
  ];
in {
  programs.niri.settings = {
    window-rules = windowRules;
    workspaces = workspaces;
  };
}
