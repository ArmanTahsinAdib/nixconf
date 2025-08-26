{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config.theme = "catppuccin";
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
    ];
    themes = {
      dracula = {
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dracula/sublime/refs/heads/master/Dracula.tmTheme";
          hash = "sha256-Z2f+fPWidZ0QggcVb1AMGJo97CFr1vT2C5tLwJ+/ilo=";
        };
      };
      catppuccin-mocha = {
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Mocha.tmTheme";
          name = "Catppuccin Mocha.tmTheme";
          hash = "sha256-OVVm8IzrMBuTa5HAd2kO+U9662UbEhVT8gHJnCvUqnc=";
        };
      };
    };

  };
}
