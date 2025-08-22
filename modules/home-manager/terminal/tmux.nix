{ config, pkgs, ... }:

{
  programs.tmux = let
    scripts = {
      tmux-open = pkgs.writeShellScriptBin "tmux-open" ''
        current_dir=$(tmux display -p "#{pane_current_path}")
        mapfile -t mylist < <(cd "$current_dir" && fd --color always --type f --strip-cwd-prefix . \
          | fzf --tmux 100%,60% --multi --style full --border none --reverse --marker '' \
          --preview 'bat -n --color always {}')
        if [[ ''${#mylist[@]} -gt 0 ]]; then
            tmux new-window -c "$current_dir" nvim ''${mylist[@]}
        fi
      '';
    };
  in {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "$TERM";
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
      fzf-tmux-url
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "gitmux directory date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -g prefix M-space
      bind-key -n C-o run-shell "${scripts.tmux-open}/bin/tmux-open"
      set-option -g allow-passthrough on
      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'
      set-option -gw xterm-keys on
      bind-key -n M-1 select-window -t 1
      bind-key -n M-2 select-window -t 2
      bind-key -n M-3 select-window -t 3
      bind-key -n M-4 select-window -t 4
      bind-key -n M-5 select-window -t 5
      bind-key -n M-6 select-window -t 6
      bind-key -n M-7 select-window -t 7
      bind-key -n M-8 select-window -t 8
      bind -n M-9 run-shell 'tmux select-window -t $(tmux list-windows | tail -1 | awk -F: "{print \$1}")'
      bind-key -n M-l send C-l
      bind-key -n M-Up resize-pane -U 5
      bind-key -n M-Down resize-pane -D 5
      bind-key -n M-Right resize-pane -R 5
      bind-key -n M-Left resize-pane -L 5


      bind-key '|' split-window -h -c '#{pane_current_path}'
      bind-key '-' split-window -c '#{pane_current_path}'
      bind-key -n M-t new-window -c '#{pane_current_path}'
      bind-key "a" set-option status

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi i send-keys -X cancel

      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-position top
      set - g status-interval 1
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      set-hook -g after-new-session 'if -F "#{==:#{session_name},popup}" "set status off; set mouse off"'

    '';
  };
}

