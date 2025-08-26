{
  pkgs,
  inputs,
  ...
}:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./core/packages.nix
    ./core/fonts.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_testing;
    initrd.systemd.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.udev.log_priority=3"
      "vt.global_cursor_default=1"
    ];
    kernel.sysctl = {
      "kernel.printk" = "3 3 3 3";
    };
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        theme =
          pkgs.fetchFromGitHub {
            owner = "kalax2";
            repo = "grub2-theme-vimix";
            rev = "220df6037a0f5c15f9fe1e35627de5849ce2b912";
            sha256 = "sha256-mEvTmIbRFqkmZtTOzQnJDg9gdqlI+yMb+FHquIUyES0=";
          }
          + "/Vimix";
      };
    };
    consoleLogLevel = 0;
    plymouth = {
      enable = true;
    };

  };

  networking = {
    hostName = "sparta";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Dhaka";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "bn_BD/UTF-8" ];
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-openbangla-keyboard
          fcitx5-nord
        ];
      };
    };
  };

  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-v24n";
    keyMap = "us";
  };

  services = {
    displayManager.sddm = {
      enable = true;
      package = pkgs.libsForQt5.sddm;
      theme = "${pkgs.sddm-chili-theme}/share/sddm/themes/chili";
      wayland.enable = true;

      extraPackages = with pkgs.libsForQt5.qt5; [
        qtquickcontrols
        qtgraphicaleffects
      ];
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    blueman.enable = true;
    gvfs.enable = true;
    gnome.sushi.enable = true;
    gnome.gnome-keyring.enable = true;
    upower.enable = true;
    libinput.enable = true;
    openssh.enable = true;
    flatpak = {
      enable = true;
      packages = [ "page.codeberg.libre_menu_editor.LibreMenuEditor" ];
    };
    locate = {
      enable = true;
      interval = "4hours";
    };
  };

  security.pam.services = {
    hyprland.enableGnomeKeyring = true;
    hyprlock = {
      text = ''
        auth      include  login
        account   include  login
        password  include  login
        session   include  login
      '';
    };

  };
  hardware = {
    bluetooth.enable = true;
    graphics = {
      package = pkgs-unstable.mesa;
      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
  };
  documentation = {
    man.generateCaches = true;
  };

  environment = {
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      SHELL = "zsh";
    };
    etc = {
      # "/brave/policies/managed/GroupPolicy.json".source = ./dots/brave-policies.json;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
    overlays = [
      inputs.nixpkgs-wayland.overlay

      (import ../../overlays/thunar.nix)
    ];
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.adib = {
      description = "Arman Tahsin Adib";
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "input"
      ];
      useDefaultShell = true;
      packages = [ ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    terminal-exec = {
      enable = true;
      settings = {
        GNOME = [
          "com.raggesilver.BlackBox.desktop"
          "org.gnome.Terminal.desktop"
        ];
        default = [ "kitty.desktop" ];
      };
    };
  };
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "daily";
      };
      flake = "/home/adib/nixconf";
    };

    zsh = {
      enable = true;
    };
    command-not-found.enable = false;
    nix-index.enable = true;
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
    hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
    file-roller.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    mtr.enable = true;
  };
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    optimise = {
      automatic = true;
      dates = "daily";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "adib" ];
      max-jobs = "auto";
      cores = 0;
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
    };
  };

  system = {
    stateVersion = "25.11";
    autoUpgrade = {
      enable = true;
      flake = "github:ArmanTahsinAdib/nixconf";
      flags = [
        "--recreate-lock-file"
        "--commit-lock-file"
      ];
      dates = "03:00";
    };
  };
}
