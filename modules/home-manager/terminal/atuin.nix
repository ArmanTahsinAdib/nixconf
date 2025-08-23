{ ... }:
{
  programs.atuin = {
    enable = true;
    daemon = {
      enable = true;
    };
    flags = [
      "--disable-ctrl-r"
    ];
    settings = {
      style = "full";
      show_help = false;
      show_tabs = false;
      inline_height = 14;
      enter_accept = true;
      keymap_mode = "vim-normal";
      search_mode = "prefix";
      theme.name = "catppuccin-mocha-mauve";
    };
    themes = {
      "catppuccin-mocha-mauve" = {
        theme.name = "catppuccin-mocha-mauve";
        colors = {
          AlertInfo = "#a6e3a1";
          AlertWarn = "#fab387";
          AlertError = "#f38ba8";
          Annotation = "#cba6f7";
          Base = "#cdd6f4";
          Guidance = "#9399b2";
          Important = "#f38ba8";
          Title = "#cba6f7";
        };
      };
    };
  };

}
