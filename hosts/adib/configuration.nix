{ config, lib, pkgs, inputs, ... }:
let
  pkgs-unstable =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in {
  imports =
    [ ./hardware-configuration.nix ./core/packages.nix ./core/fonts.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub = {
        enable = true;

        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        configurationLimit = 5;
      };
    };
    consoleLogLevel = 0;
    plymouth = { enable = true; };

  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Dhaka";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
      theme = "${pkgs.sddm-chili-theme}/share/sddm/themes/chili";
      wayland.enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    blueman.enable = true;
    upower.enable = true;
    libinput.enable = true;
    openssh.enable = true;
    gnome.sushi.enable = true;
    jupyter.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {

      package = pkgs-unstable.mesa;

      # if you also want 32-bit support (e.g for Steam)
      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
  };

  documentation.man.generateCaches = true;

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      SHELL = "zsh";
    };
    etc = {
      "/brave/policies/managed/GroupPolicy.json".source =
        ./dots/brave-policies.json;
    };

  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.adib = {
      description = "Arman Tahsin Adib";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "input" ];
      useDefaultShell = true;
      packages = with pkgs; [ kitty firefox brightnessctl git wget ];
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

    zsh = { enable = true; };
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
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    nautilus-open-any-terminal.enable = true;
    locate = {
      enable = true;
      interval = "4hours";
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
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
        GNOME =
          [ "com.raggesilver.BlackBox.desktop" "org.gnome.Terminal.desktop" ];
        default = [ "kitty.desktop" ];
      };
    };
  };

  programs.mtr.enable = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  system = {
    stateVersion = "25.11";
    autoUpgrade = {
      enable = true;
      flake = "github:ArmanTahsinAdib/nixos";
      dates = "03:00";
    };
  };
}
