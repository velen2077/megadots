{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [
          {
            namespace = "^quickshell-wallpaper$";
          }
        ];
        #place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "^quickshell-overview$";
          }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "^swww-daemon$";
          }
        ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        clip-to-geometry = true;
      }
      {
        matches = [
          {app-id = "firefox";}
        ];
        open-on-workspace = "web";
      }

      # Vesktop
      {
        matches = [
          {app-id = "vesktop";}
        ];
        open-on-workspace = "chat";
      }
    ];
  };
}
