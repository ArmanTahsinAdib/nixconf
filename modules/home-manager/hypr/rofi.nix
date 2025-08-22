{ config, pkgs, ... }:
{
  programs.rofi = {

    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-emoji-wayland
      rofi-calc
    ];
    location = "left";
    modes = [
      "drun"
      "filebrowser"
      "run"
      "recursivebrowser"
    ];
    cycle = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        configuration = {
          show-icons = true;
          display-drun = "";
          display-run = "";
          display-filebrowser = "";
          display-recursivebrowser = "󰈞";
          display-emoji = "󰞅";
          display-window = "";
          display-calc = "";
          drun-display-format = "{name}";
          window-format = "{w} · {c} · {t}";
        };
        "*" = {
          border-colour = mkLiteral "#a6c8ff";

        };
      };
  };
}
