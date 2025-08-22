{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.apple-cursor;
    size = 40;
    hyprcursor = {
      enable = true;
      size = 40;
    };

    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Green-Dark";
      package = pkgs.orchis-theme;
    };
    iconTheme = {
      name = "kora-pgrey";
      package = pkgs.kora-icon-theme;
    };
    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 40;
    };

    font = {
      name = "SF Pro Text";
      size = 11;
    };
  };
  qt = {
    enable = true;
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "40";
    HYPRCURSOR_THEME = "macOS";
    HYPRCURSOR_SIZE = "40";
    XCURSOR_THEME = "macOS";
  };
}
