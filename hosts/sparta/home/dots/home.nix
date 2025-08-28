{
  pkgs,
  spicetify-nix,
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
  };

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-openbangla-keyboard
          fcitx5-nord
        ];
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "openbangla";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "openbangla";
          };

          globalOptions = {
            Hotkey = {
              EnumerateWithTriggerKeys = true;
              EnumerateSkipFirst = false;
              ModifierOnlyKeyTimeout = 250;
            };
            "Hotkey/TriggerKeys" = {
              "0" = "Super+space";
            };
            "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
            "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
            Behavior = {
              ActiveByDefault = false;
              PreloadInputMethod = true;
            };
          };
          addons = {
            classicui.globalSection = {
              TrayOutlineColor = "#000000";
              TrayTextColor = "#ffffff";
              PreferTextIcon = "True";
              ShowLayoutNameInIcon = "True";
              UseInputMethodLanguageToDisplayText = "True";
              Theme = "Nord-Dark";
              UseAccentColor = "True";
            };

            clipboard.sections.TriggerKey."0" = "Super+semicolon";
            unicode.sections = {
              TriggerKey."0" = "Control+Alt+Shift+U";
              DirectUnicodeMode."0" = "Shift+Super+U";
            };
          };
        };
      };
    };
  };
  services = {
    batsignal = {
      enable = true;
      extraArgs = [ "-f=95" ];
    };
  };
  programs = {
    atuin = {
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
      };
    };

    tealdeer = {
      enable = true;
      package = pkgs.tlrc;
      enableAutoUpdates = true;
      settings = {
        display = {
          compact = false;
        };
      };
    };
    bat = {
      enable = true;
      config.theme = "catppuccin-mocha";
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
      ];
      themes = {
        tokyonight = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/enkia/enki-theme/refs/heads/master/scheme/Enki-Tokyo-Night.tmTheme";
            hash = "sha256-9+wO/deSOaEbtZKGlNcIIxcNOAMTpfAAEUG9ts6RcBo=";
          };
        };
        "enki-alt" = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/enkia/enki-theme/refs/heads/master/scheme/Enki-Alt.tmTheme";
            hash = "sha256-k4Y0ijayZLHBeXK4w2WZ+w8oBHyoxn6aDCL/ynhGbeg=";
          };
        };
        enki = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/enkia/enki-theme/refs/heads/master/scheme/Enki.tmTheme";
            hash = "sha256-5qe9gF9glCaB860PyzKAfU8178aguaRcGj+xbx6wkdE=";
          };
        };
        "enki-aster" = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/enkia/enki-theme/refs/heads/master/scheme/Enki-Aster.tmTheme";
            hash = "sha256-hVDgHg6YJpzReZb4/RN1hQQ+sYlkvSJ+qogf/cNGx4A=";
          };
        };

        "enki-aster-red" = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/enkia/enki-theme/refs/heads/master/scheme/Enki-Aster-red.tmTheme";
            hash = "sha256-DytHvW1dyK+iiONZwZd4N+Q5YMnRFyF5gZR7OMSgxW4=";
          };
        };

        catppuccin-mocha = {
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Mocha.tmTheme";
            name = "Catppuccin Mocha.tmTheme";
            hash = "sha256-OVVm8IzrMBuTa5HAd2kO+U9662UbEhVT8gHJnCvUqnc=";
          };
        };
      };

    };
    btop = {

      settings.theme_background = false;
      settings.vim_keys = true;
      enable = true;
    };
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
    };

    lazygit.enable = true;
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-eco
        gh-copilot
      ];
    };
    gh-dash.enable = true;

    mpv = {
      enable = true;
      includes = [
        "${pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/mpv/refs/heads/main/themes/mocha/mauve.conf";
          hash = "sha256-t+TotYyovSKFmLJRx8+XagwgQOBLiEGufom5ni0KkrA=";
        }}"
      ];
    };

    cava.enable = true;

    neovim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = with pkgs; [
        taplo
        nil
        prettier
        vscode-langservers-extracted
        tailwindcss-language-server
        nixd

        llvmPackages_18.clang-tools
        emmet-ls
        emmet-language-server
        bash-language-server
        shfmt
        lua-language-server
        luajitPackages.luarocks
        python314Full
        ruff
        pyright
        python313Packages.python-lsp-server
        black
        jdt-language-server
        stylua
        nodejs_24
        ripgrep
        fd
        silicon
        lazygit
        markdownlint-cli2
        imagemagick
        marksman
        vimPlugins.vim-markdown-toc
        hyprls
      ];
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
      plugins = with pkgs.yaziPlugins; {
        chmod = chmod;
        miller = miller;
        restore = restore;
        toggle-pane = toggle-pane;
        full-border = full-border;
        relative-motions = relative-motions;
        sudo = sudo;
      };
      initLua = "";
    };
    starship.enable = true;

    kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration = {
        enableZshIntegration = true;
        mode = "no-cursor";
      };
      themeFile = "Catppuccin-Mocha";
      font = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
        size = 16;
      };
      settings = {
        enable_audio_bell = true;
        window_padding_width = 15;
        cursor_shape = "block";
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
        background_opacity = 1.0;
        hide_window_decorations = false;
        confirm_os_window_close = 0;
        shell = "zsh";
        editor = "nvim";

        disable_ligatures = "never";
        url_style = "straight";
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
    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        strategy = [
          "history"
          "completion"
        ];
      };
      syntaxHighlighting = {
        enable = true;
      };
      history = {
        append = true;
        findNoDups = true;
        saveNoDups = true;
      };
      enableCompletion = false;
      historySubstringSearch.enable = true;
      cdpath = [ ];
      dirHashes = {
        docs = "$HOME/Documents";
        vids = "$HOME/Videos";
        dl = "$HOME/Downloads";
        conf = "$HOME/.config";
        nix = "$HOME/nixos";
        hypr = "$HOME/.config/hypr";
        all = "$HOME/all_programs";
        nv = "$HOME/.config/nvim";
      };

      shellAliases = {
        ls = "eza";
        l = "eza -lbF --git";
        ll = "eza -lbGF --git";
        llm = "eza -lbGd --git --sort=modified";
        la = "eza -lbhHigUmuSa --time-style=long-iso --git --color-scale";
        lx = "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale";
        lS = "eza -1";
        lt = "eza --tree";
        eza = "eza --icons=always";
        v = "nvim";
        c = "clear";
        cpf = "copyfile";
        g = "git";
        lg = "lazygit";
        open = "xdg-open";
      };
      plugins = [
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "you-should-use";
          src = pkgs.zsh-you-should-use;
          file = "/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
        }
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-auto-notify";
          file = "auto-notify.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-auto-notify";
            rev = "b51c934d88868e56c1d55d0a2a36d559f21cb2ee";
            sha256 = "sha256-s3TBAsXOpmiXMAQkbaS5de0t0hNC1EzUUb0ZG+p9keE=";
          };
        }
        {
          name = "zsh-catppuccin";
          file = "themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "zsh-syntax-highlighting";
            rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
            sha256 = "l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
          };
        }
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "fzf"
          "sudo"
          "aliases"
          "python"
          "history"
          "web-search"
          "copypath"
          "copyfile"
        ];
      };
      localVariables = {
        AUTO_NOTIFY_IGNORE = [
          "docker"
          "tmux"
          "zsh"
          "fish"
          "fast"
          "nvim"
          "v"
          "sesh"
        ];
        AUTO_NOTIFY_EXPIRE_TIME = 2000;
        FZF_COMPLETION_TRIGGER = "~~";
        COMPLETION_WAITING_DOTS = "true";
      };

      initContent = pkgs.lib.mkOrder 1500 ''
        export SUDO_PROMPT=$'\e[1;91m \e[1;94mYou are unstoppable: \e[0m'

        source ~/zsh-test
        (${pkgs.nitch}/bin/nitch)
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    fzf = {
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
        "--preview='bat -n --color=always {}'"
        "--reverse"
        "--preview-window=60%"
        "--border=none"
        "--ansi"
      ];
      changeDirWidgetCommand = "fd --type d --color always ";
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
        hl = "#F38BA8";
        "hl+" = "#F38BA8";
        header = "#F38BA8";
        info = "#CBA6F7";
        pointer = "#F5E0DC";
        marker = "#B4BEFE";
        prompt = "#CBA6F7";
        selected-bg = "#45475A";
        border = "#313244";
        label = "#CDD6F4";
      };
    };

    spicetify =
      let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          hidePodcasts
          shuffle
        ];
        theme = spicePkgs.themes.bloom;
        # theme = spicePkgs.themes.turntable;

        # colorScheme = "Base";
        colorScheme = "darkgreen";
      };

    tmux =
      let
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
          tmux-navi = pkgs.writeShellScriptBin "tmux-navi" ''
            for i in $(seq 1 8); do
              tmux bind-key -n "M-$i" run-shell "tmux select-window -T -t $i 2>/dev/null || true"
            done

            tmux bind-key -n M-9 run-shell 'tmux select-window -T -t $(tmux list-windows | tail -1 | awk -F: "{print \$1}")'
          '';
        };
      in
      {
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

          {
            plugin = (
              catppuccin.overrideAttrs (_: {
                src = pkgs.fetchFromGitHub {
                  owner = "omerxx";

                  repo = "catppuccin-tmux";
                  rev = "e30336b79986e87b1f99e6bd9ec83cffd1da2017";
                  sha256 = "0vgpa5m84wqcj9vbr4gvw8mnrgrfxi6la4kw609adcrf3yjbw3i2";
                };
              })
            );
            extraConfig = ''
              set -g @catppuccin_window_left_separator ""
              set -g @catppuccin_window_right_separator " "
              set -g @catppuccin_window_middle_separator " █"
              set -g @catppuccin_window_number_position "right"
              set -g @catppuccin_window_default_fill "number"
              set -g @catppuccin_window_default_text "#W"
              set -g @catppuccin_window_current_fill "number"
              set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,( ),}"
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
          sensible
          resurrect
          continuum
          fzf-tmux-url
          yank
          vim-tmux-navigator
        ];

        extraConfig = ''
          set -g pane-active-border-style 'fg=magenta,bg=default'
          set -g pane-border-style 'fg=brightblack,bg=default'
          set -g prefix M-space
          run-shell "${scripts.tmux-navi}/bin/tmux-navi"
          bind-key o run-shell "${scripts.tmux-open}/bin/tmux-open"
          set-option -g allow-passthrough on
          set -s extended-keys on
          set -as terminal-features 'xterm*:extkeys'
          set-option -gw xterm-keys on
          bind-key r source-file ~/.config/tmux/tmux.conf
          bind-key -n M-l send C-l
          bind-key -n M-Up resize-pane -U 5
          bind-key -n M-Down resize-pane -D 5
          bind-key -n M-Right resize-pane -R 5
          bind-key -n M-Left resize-pane -L 5
          bind-key -n C-Tab next-window
          bind-key -n C-BTab previous-window

          bind-key '|' split-window -h -c '#{pane_current_path}'
          bind-key '-' split-window -c '#{pane_current_path}'
          bind-key -n M-t new-window -c '#{pane_current_path}'
          bind-key "a" set-option status

          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi i send-keys -X cancel

          set -g renumber-windows on
          set -g set-clipboard on
          set -g status-position top
          set -g status-interval 1
          set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
          set -as terminal-overrides ',*:Setulc=\E[58::2::::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
          set-hook -g after-new-session 'if -F "#{==:#{session_name},popup}" "set status off; set mouse off"'

        '';
      };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
  xdg.configFile = {
    # Kvantum theme directory
    "Kvantum/Utterly-Nord".source = "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord";

    # Kvantum config file
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Utterly-Nord
    '';
    "yazi/theme.toml".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/mocha/catppuccin-mocha-mauve.toml";
      sha256 = "sha256-9hrR+mwzNyDuycYNsngk+0gnEklxGfYi6QROF33HV1A=";
    };
  };

  catppuccin = {
    enable = true;
    kvantum = {
      enable = false;
      accent = "blue";
    };
    yazi.enable = false;
    mpv.enable = false;
    starship.enable = false;
    bat.enable = false;
    fzf.enable = false;
    btop.enable = true;
    hyprland.enable = false;
    cava.transparent = true;
    kitty.enable = false;
    nvim.enable = false;
    rofi.enable = false;
    tmux.enable = false;
    waybar.enable = false;
    lazygit.enable = true;

  };
  home = {
    username = "arman-adib";
    homeDirectory = "/home/arman-adib";
    stateVersion = "25.05";

    packages = with pkgs; [
      firefoxpwa
      jq
      lazygit
      libsForQt5.qt5ct
      qt6ct
      libcanberra-gtk3
      zenity
    ];

    sessionVariables = {
      BROWSER = "brave";
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  }; # Please read the comment before changing.
  dconf.settings = {
    "org/gnome/desktop/sound" = {
      theme-name = "freedesktop";
    };
  };
  xdg = {
    userDirs.enable = true;
  };

  manual = {
    html.enable = true;
  };
}
