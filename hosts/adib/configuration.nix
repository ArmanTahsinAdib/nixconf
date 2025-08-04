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
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.udev.log_priority=3"
      "vt.global_cursor_default=1"
    ];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        # device = "nodev"; #NOTE: Disko will take care of this
      };
      grub2-theme = {
        enable = true;
        theme = "vimix";
        icon = "whitesur";
      };
    };
    consoleLogLevel = 0;
    plymouth = {
      enable = true;
    };
    initrd.systemd.enable = true;

  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Dhaka";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "bn_BD/UTF-8" ];
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
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      SHELL = "zsh";
    };
    etc = {
      "/brave/policies/managed/GroupPolicy.json".source = ./dots/brave-policies.json;
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
    settings = {
      trusted-users = [ "adib" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      trusted-substituters = [ "https://hyprland.cachix.org" ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
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
