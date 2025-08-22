{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$browser" = "${pkgs.brave}/bin/brave";
    "$terminal" = "${pkgs.kitty}/bin/kitty";
    "$file" = "${pkgs.nautilus}/bin/nautilus -w";
    "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
    bind = [
      "$mod, F, exec, $browser"
      ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
      "$mod, E, exec, $file"
      "$mod, T, exec, $terminal"
      "$mod, A, exec $menu"
      "$mod CTRL, W, exec, pkill waybar && ${pkgs.waybar}/bin/waybar"
      "$mod SHIFT, W, exec, ${pkgs.waypaper}/bin/waypaper"
      "$mod, M, exec, spotify"
      "$mod, O, exec, ${pkgs.obsidian}/bin/obsidian"
      "$mod, C, exec, ${pkgs.cheese}/bin/obsidian"
      "$mod, D, exec, ${pkgs.discord}/bin/discord"
      "$mod, I, exec, ${pkgs.pavucontrol}/bin/pavucontrol"
      "$mod, R, exec, ${pkgs.libreoffice}/bin/libreoffice --writer"

      # WINDOW_MANAGEMENT
      "$mod, Q, killactive,"
      "Alt, F4, killactive,"
      "$mod SHIFT, Q, forcekillactive,"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"
      "$mod, delete, exit,"
      "$mod, W, togglefloating,"
      "$mod, Return, fullscreen,1"
      "$mod SHIFT, Return, fullscreen,0"
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9
    ));
  };
}
