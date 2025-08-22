{
  pkgs,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--password-store=gnome"
      "--ozone-platform-hint=wayland"
      "--enable-smooth-scrolling"
      "--enable-features=TouchpadOverscrollHistoryNavigation,FluentOverlayScrollbar,FluentScrollbar,OverlayScrollbar,WaylandLinuxDrmSyncobj,WaylandPerSurfaceScale,WaylandSessionManagement,WaylandTextInputV3,WaylandUiScale,MiddelButtonClickAutoscroll"
    ];
    extensions =
      let
        ids = [
          "jjpokbgpiljgndebfoljdeihhkpcpfgl" # Material You New Tab
          "bggfcpfjbdkhfhfmkjpbhnkhnpjjeomc" # Material icon theme for Github
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "hlepfoohegkhhmjieoechaddaejaokhf" # Refined Github
          "jpdmfnflpdgefbfkafcikmhipofhanfl" # Github Repo Size
          "hdannnflhlmdablckfkjpleikpphncik" # Youtube playback speed control
          "jghecgabfgfdldnmbfkhmffcabddioke" # Volume Master
        ];
      in
      builtins.map (id: { inherit id; }) ids;
  };
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };

  xdg.mimeApps =
    let
      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name;
            value = pkgs.brave.meta.desktopFile;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
