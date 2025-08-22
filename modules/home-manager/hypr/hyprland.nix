{
  pkgs,
  ...
}:
{
  imports = [
    ./eww.nix
    ./hyprlock.nix
    ./misc.nix
  ];
  wayland = {
    windowManager.hyprland = {
      enable = true;
      package = null;
      # portalPackage = null;
      systemd = {
        variables = [ "--all" ];
        enableXdgAutostart = true;
        extraCommands = [
          "systemctl start --user polkit-gnome-authentication-agent-1.service"
        ];
      };
      settings = {
        monitor = ",highres,auto,1";
        exec-once = [
          "${pkgs.mpv}/bin/mpv ../../../hosts/sparta/dots/computer-startup.mp3 &"
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
      };
    };
  };
}
