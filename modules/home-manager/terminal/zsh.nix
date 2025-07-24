{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
    };
    syntaxHighlighting = { enable = true; };
    history = {
      append = true;
      findNoDups = true;
      saveNoDups = true;
    };
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
      lt = "eza --tree --level=2";
      eza = "eza --icons --hyperlink";
      v = "nvim";
      c = "clear";
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
        name = "zsh-system-clipboard";
        src = pkgs.zsh-system-clipboard;
        file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
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
      AUTO_NOTIFY_IGNORE =
        [ "docker" "tmux" "zsh" "fish" "fast" "nvim" "v" "sesh" ];
      AUTO_NOTIFY_EXPIRE_TIME = 2000;
      FZF_COMPLETION_TRIGGER = "~~";
      COMPLETION_WAITING_DOTS = "true";
    };

    initContent = pkgs.lib.mkOrder 1500 ''
      (nitch)
    '';
  };
}
