{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      layer = "top";
      position = "top";
      height = 30;
      margin = "0 0 0 0";
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        "tray"
      ];
      modules-center = [
        "idle_inhibitor"
        "clock"
      ];
      modules-right = [
        "backlight"
        "pulseaudio#output"
        "pulseaudio#input"
        "temperature"
        "group/hardware"
        "battery"
        "network"
        "custom/notification"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = " ";
          default = " ";
          empty = " ";
        };
        "persistent-workspaces" = {
          "*" = [
            1
            2
            3
            4
            5
          ];
        };
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      tray = {
        icon-size = 16;
        spacing = 5;
      };

      clock = {
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#bb9af7'><b>{}</b></span>";
            days = "<span color='#7aa2f7'><b>{}</b></span>";
            weeks = "<span color='#9ece6a'><b>W{}</b></span>";
            weekdays = "<span color='#e0af68'><b>{}</b></span>";
            today = "<span background='#2ac3de' color='#1a1b26'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
        format = "{:%a %d %b | %I:%M %p}";
        format-alt = "  {:%Y-%m-%d  %H:%M:%S}";
        interval = 1;
      };

      "custom/system" = {
        format = "";
        tooltip = false;
      };

      cpu = {
        format = " {usage: >3}%";
        on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.btop}/bin/btop";
      };

      memory = {
        format = " {: >3}%";
        on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.btop}/bin/btop";
      };

      temperature = {
        thermal-zone = 4;
        critical-threshold = 80;
        format = "  {temperatureC}°C";
      };

      disk = {
        format = " {percentage_used}% ";
        path = "/";
      };

      "group/hardware" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 300;
          children-class = "not-memory";
          transition-left-to-right = false;
        };
        modules = [
          "custom/system"
          "disk"
          "cpu"
          "memory"
        ];
      };

      backlight = {
        format = "{icon} {percent: >3}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
        on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl -q -e4 -n2 set 2%-";
        on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl -q -e4 -n2 set 2%+";
      };
      battery = {
        states = {
          "warning" = 30;
          "critical" = 15;
        };
        interval = 1;
        format = "{icon} {capacity: >3}%";
        format-charging = "  {capacity}%";
        format-plugged = "  {capacity}%";
        format-alt = "{icon}  {time}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      network = {
        format = " {ifname}: {ipaddr}/{cidr}";
        format-wifi = "{icon} {signalStrength}%";
        format-icons = [
          "󰤟 "
          "󰤢 "
          "󰤥 "
          "󰤨 "
        ];
        format-ethernet = " {ifname}: {ipaddr}/{cidr}";
        format-disconnected = "⚠  Disconnected";
        tooltip-format = " {ifname} via {gwaddri}";
        tooltip-format-wifi = "{icon}   {essid} ({signalStrength}%)";
        tooltip-format-ethernet = "  {ifname} ({ipaddr}/{cidr})";
        tooltip-format-disconnected = "⚠  Disconnected";
        format-alt = "{icon}  <span foreground='#99ffdd'>\uf019 {bandwidthDownBytes}</span> <span foreground='#ffcc66'>\uf093 {bandwidthUpBytes}</span>";
        interval = 2;
        on-click-middle = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
      };

      "pulseaudio#output" = {
        format = "{icon} {volume: >3}%";
        format-bluetooth = "{icon} {volume: >3}%";
        format-muted = " muted";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
          ];
        };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      };

      "pulseaudio#input" = {
        format-source = " ";
        format-source-muted = " ";
        format = "{format_source}";
        on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "custom/power" = {
        format = "⏻";
        on-click = "${pkgs.wlogout}/bin/wlogout";
        tooltip = false;
      };

      "custom/launcher" = {
        format = "";
        on-click = "${pkgs.rofi-wayland}/bin/rofi -show drun -replace";
        tooltip = false;
      };

      "custom/notification" = {
        tooltip-format = "Left: Notifications\nRight: Do not disturb";
        format = "{icon}";
        format-icons = {
          notification = "<span rise='8pt'><span foreground='red'><sup></sup></span></span>";
          none = "";
          dnd-notification = "<span rise='8pt'><span foreground='red'><sup></sup></span></span>";
          dnd-none = "";
          inhibited-notification = "<span rise='8pt'><span foreground='red'><sup></sup></span></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span rise='8pt'><span foreground='red'><sup></sup></span></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
        on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
        escape = true;
      };
    };

    style = ''
      @define-color base   #24273a;
      @define-color mantle #1e2030;
      @define-color crust  #181926;

      @define-color text     #cad3f5;
      @define-color subtext0 #a5adcb;
      @define-color subtext1 #b8c0e0;

      @define-color surface0 #363a4f;
      @define-color surface1 #494d64;
      @define-color surface2 #5b6078;

      @define-color overlay0 #6e738d;
      @define-color overlay1 #8087a2;
      @define-color overlay2 #939ab7;

      @define-color blue      #8aadf4;
      @define-color lavender  #b7bdf8;
      @define-color sapphire  #7dc4e4;
      @define-color sky       #91d7e3;
      @define-color teal      #8bd5ca;
      @define-color green     #a6da95;
      @define-color yellow    #eed49f;
      @define-color peach     #f5a97f;
      @define-color maroon    #ee99a0;
      @define-color red       #ed8796;
      @define-color mauve     #c6a0f6;
      @define-color pink      #f5bde6;
      @define-color flamingo  #f0c6c6;
      @define-color rosewater #f4dbd6;


      * {
        color: @lavender;
        border: 0;
        padding: 0 0;
        font-family: "Fira sans Semibold", "Symbols Nerd Font", "Font Awesome 6 Free";
      }

      window#waybar {
        border: 0px solid rgba(0, 0, 0, 0);
        background-color: rgba(0, 0, 0, 0);
      }

      #workspaces button {
        color: @base;
        border-radius: 50%;
        margin: 0px 0px;
        padding: 4 6 2 0;
      }

      #workspaces button:hover {
        color: @mauve;
        box-shadow: none;
        /* Remove predefined box-shadow */
        text-shadow: none;
        /* Remove predefined text-shadow */
        border: 0px;
        background: none;
      }

      #workspaces button:hover * {
        color: @mauve;
        background-color: @base;
      }

      #workspaces * {
        color: whitesmoke;
      }

      #workspaces {
        border-style: solid;
        background-color: @base;
        opacity: 1;
        border-radius: 10px;
        margin: 8px 0px 8px 8px;
        padding: 0px 10px;
      }

      #workspaces button.focused {
        color: @mauve;
        border-radius: 20px;
        /* background-color: @flamingo; */
      }

      #workspaces button.focused * {
        color: @mauve;
      }

      #clock,
      #custom-swap,
      #battery,
      #cpu,
      #memory,
      #disk,
      #idle_inhibitor,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #window,
      #tray,
      #custom-power,
      #custom-launcher,
      #custom-system{
        padding: 5px 8px;
        border-style: solid;
        background-color: shade(@base, 1);
        opacity: 1;
        margin: 8px 0;
      }


      #window {
        border-radius: 10px;
        color: @base;
        margin-left: 5px;
        margin-right: 5px;
        background-color: @mauve;
      }

      window#waybar.empty #window {
        background-color: transparent;
      }

      #custom-swap {
        border-radius: 10px;
        color: @base;
        margin-left: 15px;
        background-color: @mauve;
      }

      #clock {
        color: @sky;
        border-radius: 10px;
        margin: 8px 10px;
      }

      #backlight {
        color: @yellow;
        border-radius: 10px 0 0 10px;
      }

      #battery {
        color: @green;
        border-radius: 0 10px 10px 0;
        margin-right: 10px;
      }

      #battery.charging {
        color: #81a1c1;
      }

      @keyframes blink {
        to {
          color: @red;
        }
      }

      #battery.warning:not(.charging) {
        color: @yellow;
      }

      #battery.critical:not(.charging) {
        color: #bf616a;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #custom-system {
        color: @sky;
      }

      #cpu {
        color: @sky;
      }

      #cpu #cpu-icon {
        color: @sky;
      }

      #memory {
        color: @sky;
      }

      #disk {
        color: @sky;
      }

      #network.disabled {
        color: #bf616a;
      }

      #network {
        color: @green;
        border-radius: 10px;
        margin-right: 5px;
      }

      #network.disconnected {
        color: #bf616a;
      }

      #pulseaudio.output {
        color: @flamingo;
      }

      #pulseaudio.output.muted {
        color: #3b4252;
      }

      #temperature {
        color: @teal;
        border-radius: 10px 0 0 10px;
      }

      #temperature.critical {
        color: @red;
      }

      #idle_inhibitor {
        background-color: shade(@base, 1);
        color: @green;
        border-radius: 10px;
      }

      #idle_inhibitor.activated {
        background-color: shade(@base, 1);
        color: @red;
        border-radius: 10px;
      }

      tooltip {
        background: shade(@base, 0.9);
        color: @text;
        border-radius: 10px;

        font-family: "Fira sans Semibold";
      }

      tooltip * {
        padding: 5px;
        border-radius: 1px;

        font-family: "Fira sans Semibold";
      }

      #tray {
        background-color: @base;
        margin: 8px 10px;
        border-radius: 10px;
      }

      #tray menu * {
        padding: 0px 5px;
        /* transition: all .3s ease;  */
      }

      #tray menu separator {
        padding: 0px 5px;
        transition: all 0.3s ease;
      }
      #custom-launcher,
      #custom-power {
      }

      #custom-launcher {
        background-color: @mauve;
        color: @base;
        border-radius: 10px;
        padding: 5px 10px;
        margin-left: 15px;
      }

      #custom-power {
        color: @base;
        background-color: @red;
        border-radius: 10px;
        margin-left: 5px;
        margin-right: 15px;
        padding: 5px 10px;
      }

    '';

  };
}
