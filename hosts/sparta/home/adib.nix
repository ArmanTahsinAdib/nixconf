{
  pkgs,
  lib,
  spicetify-nix,
  ...
}:

{

  imports = [
    ./../../../modules/home-manager/terminal/terminal.nix
    ./../../../modules/home-manager/hypr/hyprland.nix
  ];

  home = {
    username = "adib";
    homeDirectory = lib.mkDefault "/home/adib";
    packages = with pkgs; [
      brightnessctl
      rofi-wayland
      wl-clipboard
      cliphist
      wlogout
      swaynotificationcenter
      libinput-gestures
      swappy
      eww
      waypaper
      grimblast
      wf-recorder
    ];

    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      GDK_BACKEND = "wayland,x11";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland,xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      TERMINAL = "kitty";
      BROWSER = "brave";
      FILE_MANAGER = "nautilus";
    };

    shellAliases = {
      g = "git";
      v = "nvim";
      c = "clear";
    };
    shell.enableZshIntegration = true;

    stateVersion = "25.05";
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
            Behavior = {
              ActiveByDefault = false;
            };
            Hotkey = {
              EnumerateWithTriggerKeys = true;
              EnumerateSkipFirst = false;
              ModifierOnlyKeyTimeout = 250;
            };
            "Hotkey/triggerKeys"."0" = "Super+space";
            "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
            "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
          };
          addons = {
            classicui.globalSection.Theme = "Nord-Dark";
            clipboard.globalSection.TriggerKey."0" = "Super+semicolon";
            unicode.sections = {
              TriggerKey."0" = "Control+Alt+Shift+U";
              DirectUnicodeMode."0" = "Shift+Super+U";
            };
          };
        };
      };
    };
  };

  programs = {
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

        colorScheme = "darkgreen";
      };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = with pkgs; [
        shfmt
        rustup
        lua-language-server
        luajitPackages.luarocks
        python314Full
        stylua
        nodejs_24
        ripgrep
        fd
        silicon
        lazygit
      ];
    };
    git = {
      enable = true;
      userName = "ArmanTahsinAdib";
      userEmail = "adib.armantahsin@gmail.com";
      package = pkgs.gitFull;
      aliases = {
        co = "checkout";
        cl = "clone";
        a = "add";
        i = "init";
      };
      delta = {
        enable = true;
      };
      lfs.enable = true;
    };

    lazygit = {
      enable = true;
      settings = {
        theme = {
          activeBorderColor = [
            "#cba6f7"
            "bold"
          ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#cba6f7" ];
          unstagedChangesColor = [ "#f38ba8" ];
          defaultFgColor = [ "#cdd6f4" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
          authorColors = {
            "*" = [ "#b4befe" ];
          };
        };
      };

    };

    man.generateCaches = true;

    home-manager.enable = true;

  };

  xdg = {
    enable = true;
    configFile = {
      nvim.source = "./dots/nvim";
      "swayosd/config.toml".source = "./dots/swayosd.toml";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.kde.okular.desktop" ];
      };
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  news.display = "notify";
  manual.html.enable = true;

  services = {
    gnome-keyring.enable = true;
    polkit-gnome.enable = true;
    poweralertd.enable = true;
    swww.enable = true;
  };

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };
}
