{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type f --color always";
    defaultOptions = [
      "--multi"
      "--info=inline"
      "--wrap"
      "--bind 'ctrl-/:change-preview-window(hidden|)'"
      "--border sharp"
      "--ansi"
    ];
    fileWidgetCommand = "fd --type f --color always";
    fileWidgetOptions = [
      "--height 15"
      "--style=full"
      "--preview='bat {}'"
      "--reverse"
      "--preview-window=60%"
      "--border=none"
      "--ansi"
    ];
    changeDirWidgetCommand = "fd --type d --color always";
    changeDirWidgetOptions = [
      "--height 14"
      "--border sharp"
      "--preview='eza --color=always {}'"
      "--reverse"
      "--preview-window=down,10%,border-sharp"
      "--ansi"
    ];
    tmux.enableShellIntegration = true;
    colors = {
      bg = "#1E1E2E";
      "bg+" = "#313244";
      fg = "#CDD6F4";
      "fg+" = "#CDD6F4";
      spinner = "#F5E0DC";
      h1 = "#F38BA8";
      "hl+" = "#F38BA8";
      header = "#F38BA8";
      info = "#CBA6F7";
      pointer = "#F5E0DC";
      marker = "#B4BEFE";
      prompt = "#CBA6F7";
      selected-bg = "#45475A";
      border = "#313244";
      lable = "#CDD6F4";
    };
  };
}
