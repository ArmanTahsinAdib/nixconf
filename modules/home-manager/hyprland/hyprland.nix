{ pkgs, lib, config, ... }: {
  wayland = {
    windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd = {
        target = "hyprland-session.target";
        variables = [ "--all" ];
        enableXdgAutostart = true;
        extraCommands = [
          "systemctl start --user polkit-gnome-authentication-agent-1.service"
        ];
      };
      settings = {
        monitor = ",highres,auto,1";
        exec-once = [
          "${pkgs.mpv}/bin/mpv ~/nixos/hosts/arman-adib/dots/computer-startup.mp3 &"
          "${pkgs.swaync}/bin/swaync &"
          "${pkgs.swww}/bin/swww-daemon &"
          "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &"
          "${pkgs.blueman}/bin/blueman-applet &"
          "${pkgs.udiskie}/bin/udiskie &"
          "${pkgs.protonvpn-gui}/bin/protonvpn-app --start-minimized &"
          "${pkgs.waybar}/bin/waybar &"
          "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both &"
          "${pkgs.hypridle}/bin/hypridle"
          "${pkgs.nautilus}/bin/nautilus --gapplication-service &"
        ];
        "$mod" = "SUPER";
        "$browser" = "${pkgs.brave}/bin/brave";
        "$file" = "${pkgs.nautilus}/bin/nautilus --new-window";
        "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
        bind = [

          "$mod, F, exec, $browser"
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
          "$mod, E, exec, $file"
          "$mod, A, exec $menu"
          "SUPER_SHIFT, W, exec, pkill waybar && waybar"

        ] ++ (builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));
      };
    };
  };
}

