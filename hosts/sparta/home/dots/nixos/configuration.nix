{
  config,
  lib,
  pkgs,
  ...
}:

{

  # services.auto-cpufreq.enable = true;
  services.thermald.enable = true;
  services.geoclue2.enable = true;
  # programs.nix-ld.enable = true;

  # systemd.tmpfiles.rules = [
  #   "A /home/arman-adib - - - - user:sddm:x"
  #   "A+ /home/arman-adib - - - - m::--x"
  #   "A /home/arman-adib/.face.icon - - - - user:sddm:r"
  #   "A+ /home/arman-adib/.face.icon - - - - m::r--"
  #   "z /home/arman-adib/.ssh 0700 arman-adib users -"
  #   "z /home/arman-adib/.ssh/id_ed25519 0600 arman-adib users -"
  # ];

  systemd.tmpfiles.rules = [
    # home dir: owner rwx, others just x (needed for sddm to traverse into it)
    "z /home/arman-adib 0711 arman-adib users -"

    # make the face icon world-readable
    "z /home/arman-adib/.face.icon 0644 arman-adib users -"

    # keep your ssh stuff locked down
    # "z /home/arman-adib/.ssh 0700 arman-adib users -"
    # "z /home/arman-adib/.ssh/id_ed25519 0600 arman-adib users -"
  ];

  programs = {
    git.enable = true;
    nh.enable = true;

    nix-index.enable = true;

    zsh.enable = true;

    fzf.keybindings = true;

    fzf.fuzzyCompletion = true;
    nm-applet.enable = true;
    firefox = {
      enable = true;
    };
    thunderbird.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    # waybar.package = pkgs.waybar.overrideAttrs (oldAttrs: {
    #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    # });

    file-roller.enable = true;
    nautilus-open-any-terminal.enable = true;

    nautilus-open-any-terminal.terminal = "kitty";
  };
  services = {
    displayManager = {

      # sddm = {
      #   wayland.enable = true;
      #   enable = true;
      #   package = pkgs.libsForQt5.sddm;
      #
      #   enableHidpi = true;
      #
      #   extraPackages = with pkgs; [
      #     libsForQt5.qt5.qtgraphicaleffects
      #   ];
      #
      #   settings = {
      #     Theme = {
      #       # Font = "SF Pro Display";
      #       CursorTheme = "macOS";
      #       CursorSize = "40";
      #     };
      #   };
      #
      #   theme = "${pkgs.sddm-chili-theme}/share/sddm/themes/chili";
      #   # theme = "${
      #   #   (pkgs.sddm-astronaut.override { embeddedTheme = "pixel_sakura"; })
      #   # }/share/sddm/themes/sddm-astronaut-theme";
      #   #
      # };
    };

    blueman.enable = true;

    printing = {
      enable = true;
    };

    upower.enable = true;
    gnome.sushi.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;

    udev.packages = [
      pkgs.swayosd
      pkgs.pulseaudio
    ];

    udev.extraRules = ''
      ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", \
        RUN+="${pkgs.systemd}/bin/systemctl start power-plug-sound.service"

      ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", \
        RUN+="${pkgs.systemd}/bin/systemctl start power-unplug-sound.service"
    '';
  };
  documentation = {
    man = {
      generateCaches = true;
    };
  };
  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #   };
  #   virtualbox = {
  #     host = {
  #       enable = true;
  #     };
  #   };
  # };
  users = {
    extraGroups.vboxusers.members = [ "arman-adib" ];

    users.arman-adib = {
      description = "Arman Tahsin Adib";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
      ];
      initialPassword = "ARMANADIB";
      shell = pkgs.zsh;

    };
  };
  xdg = {
    terminal-exec.enable = true;

    portal.enable = true;

    portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # i18n = {
  #   defaultLocale = "en_US.UTF-8";
  #   extraLocales = [ "bn_BD/UTF-8" ];
  #   inputMethod = {
  #     enable = true;
  #     type = "fcitx5";
  #     fcitx5 = {
  #       waylandFrontend = true;
  #       addons = with pkgs; [
  #         fcitx5-openbangla-keyboard
  #         # fcitx5-gtk
  #         fcitx5-nord
  #       ];
  #     };
  #   };
  # };
  imports = [ ./hardware-configuration.nix ];

  boot.initrd.systemd.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=0"
      "rd.udev.log_priority=0"
      "vt.global_cursor_default=0"
    ];
    kernel.sysctl = {
      "kernel.printk" = "0 0 0 0";
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

  # security.polkit.debug = true;
  networking.firewall.checkReversePath = false;
  security.rtkit.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # VA-API video decode for Gen8+
        intel-compute-runtime # ✅ OpenCL GPU driver (Neo)
        # intel-opencl-clang # Needed by Neo
        intel-graphics-compiler # Needed by Neo
        level-zero # Optional: low-level interface used by newer runtimes
      ];
    };
  };

  nixpkgs = {

    config = {
      allowUnfree = true;
      allowBroken = true;
    };
    overlays = [
      (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];
  };

  networking.networkmanager.enable = true;
  time = {
    timeZone = "Asia/Dhaka";
  };

  console = {
    packages = with pkgs; [ terminus_font ];
    # font = ${pkgs.terminus_font}/share/fonts/terminus/ter-u32n;
    earlySetup = true;
    font = "ter-v24n";
    colors = [
      "002b36"
      "dc322f"
      "859900"
      "b58900"
      "268bd2"
      "d33682"
      "2aa198"
      "eee8d5"
      "002b36"
      "cb4b16"
      "586e75"
      "657b83"
      "839496"
      "6c71c4"
      "93a1a1"
      "fdf6e3"
    ];

  };
  nix.settings = {
    max-jobs = "auto";
    cores = 0;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.variables.QT_PLUGIN_PATH = lib.mkForce "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}";
  environment.systemPackages = with pkgs; [
    (fenix.complete.withComponents [
      "rust-docs"
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    (pkgs.writeShellScriptBin "rustbook" ''
      exec ${pkgs.xdg-utils}/bin/xdg-open \
        ${pkgs.fenix.complete.withComponents [ "rust-docs" ]}/share/doc/rust/html/book/index.html
    '')
    (pkgs.callPackage ./pkgs/quran-conpanion { })
    (pkgs.callPackage ./pkgs/nautilus-sendto { })
    # (pkgs.callPackage ./pkgs/udvash { inherit gconf; })

    gemini-cli
    gnumake
    gcc
    temurin-bin-24
    (python313.withPackages (
      ps: with ps; [
        requests
        numpy
        pandas
        (matplotlib.override { enableQt = true; })
        scipy
      ]
    ))

    wineWowPackages.waylandFull
    winetricks
    brightnessctl
    wget
    unzip
    bc
    clang-tools
    zed-editor
    vscode
    fastfetch
    ffmpeg
    font-manager
    rust-analyzer-nightly

    cargo-generate
    fuse2
    cmatrix
    eww
    pavucontrol
    nodejs_24
    gnome-calculator
    gnome-maps
    gnome-clocks
    libcanberra
    udiskie
    # gtk3
    # gtk4
    pulseaudio
    kora-icon-theme
    reversal-icon-theme
    nixfmt-rfc-style
    ruff
    nil
    nixd
    mpv
    protonvpn-gui
    hyprlock
    hypridle
    hyprls
    hyprpicker
    hyprsunset
    wtype
    psmisc
    discord
    kdePackages.okular
    kitty
    quickgui
    libreoffice-fresh
    obsidian
    blender
    gimp3
    swww
    waypaper
    wlogout
    home-manager
    playerctl
    grimblast
    swappy
    gthumb
    satty
    ripgrep
    fd
    chafa
    cheese
    yazi
    btop
    zoxide
    eza
    apple-cursor
    tela-circle-icon-theme
    whitesur-icon-theme
    kora-icon-theme
    bibata-cursors
    nwg-look
    gtk3
    gtk4
    orchis-theme
    swaynotificationcenter
    libnotify
    wl-clipboard
    cliphist
    wl-clip-persist
    swayosd
    # (waybar.overrideAttrs (oldAttrs: {
    #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    # }))
    (rofi-wayland.override {
      plugins = with pkgs; [
        rofi-emoji-wayland
        rofi-calc
      ];
    })

    glib
    nautilus

    folder-color-switcher

    turtle

    trash-cli
    polkit
    polkit_gnome
    luajitPackages.luarocks
    networkmanagerapplet
  ];

  fonts = {
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        emoji = [ "Apple Color Emoji" ];
        serif = [
          "Fira Sans"
          "Noto Serif Bengali"
        ];
        sansSerif = [
          "Fira Sans"
          "Noto Sans Bengali"
        ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };

    };
    packages = with pkgs; [

      geist-font
      caladea
      vista-fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      fira-sans
      google-fonts
      corefonts
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
      lohit-fonts.bengali
      (stdenv.mkDerivation {
        pname = "sn-pro";
        version = "1.5.0";

        src = fetchFromGitHub {
          owner = "supernotes";
          repo = "sn-pro";
          rev = "d864371f09d5e58abd8f9030b27d864e7262e611";
          hash = "sha256-JfV42xLJ1yT7YNv2VD0CYGmC3BgUlROewzbek4T+0MA=";
        };

        installPhase = ''
          mkdir -p $out/share/fonts
          cp exports/SNPro/* $out/share/fonts
        '';

        meta = with lib; {
          description = "SN Pro Font Family";
          homepage = "https://supernotes.app/open-source/sn-pro/";
          license = licenses.ofl;
          platforms = platforms.all;
        };
      }

      )

      (pkgs.stdenv.mkDerivation {
        pname = "sf-pro-fonts";
        version = "1.0";

        src = pkgs.fetchFromGitHub {
          owner = "sahibjotsaggu";
          repo = "San-Francisco-Pro-Fonts";
          rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
          sha256 = "0zm9112y5x6z36mhcqlga4lmiqjhp1n7qiszmd3h3wi77z3c81cq";
        };

        installPhase = ''
          mkdir -p $out/share/fonts/{truetype,opentype}
          cp -v *.ttf $out/share/fonts/truetype/
          cp -v *.otf $out/share/fonts/opentype/
        '';
      })
    ];
  };

  security.polkit.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.hyprlock = {
    text = ''
      auth      include  login
      account   include  login
      password  include  login
      session   include  login
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  # system.stateVersion = "25.11"; # Did you read the comment?
  system.stateVersion = config.system.nixos.release;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  systemd.services.power-plug-sound = {
    description = "Play power plug sound";
    serviceConfig = {
      Environment = [
        "PULSE_SERVER=unix:/run/user/1000/pulse/native"
        "PULSE_COOKIE=/home/arman-adib/.config/pulse/cookie"
        "XDG_RUNTIME_DIR=/run/user/1000"
      ];
      ExecStart = "${pkgs.pulseaudio}/bin/paplay /run/current-system/sw/share/sounds/freedesktop/stereo/power-plug.oga";
      User = "arman-adib"; # run as your user instead of root
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.power-unplug-sound = {
    description = "Play power unplug sound";
    serviceConfig = {
      Environment = [
        "PULSE_SERVER=unix:/run/user/1000/pulse/native"
        "PULSE_COOKIE=/home/arman-adib/.config/pulse/cookie"
        "XDG_RUNTIME_DIR=/run/user/1000"
      ];
      ExecStart = "${pkgs.pulseaudio}/bin/paplay /run/current-system/sw/share/sounds/freedesktop/stereo/power-unplug.oga";
      User = "arman-adib"; # run as your user instead of root
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc.";
    documentation = [ "https://github.com/ErikReider/SwayOSD" ];
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];
    after = [ "graphical.target" ];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };
}
