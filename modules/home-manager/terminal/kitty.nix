{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 15;
    };
    settings = {
      enable_audio_bell = true;
      font_size = 11.5;
      window_padding_width = 15;
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      background_opacity = 0.8;
      hide_window_decorations = false;
      confirm_os_window_close = 0;
      term = "xterm-256color";
      shell = "zsh";
      editor = "nvim";

      disable_ligatures = "never";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      cursor = "#a6e3a1";

      dynamic_background_opacity = true;
      copy_on_select = true;

      mouse_map = "right press ungrabbed paste_from_clipboard";
    };
    keybindings = {
      "ctrl+backspace" = "send_text all \\x17";
      "ctrl+tab" = "send_text all \\x1b[27;5;9~";
      "ctrl+shift+tab" = "send_text all \\x1b[27;6;9~";
    };
  };
}
