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
        src = pkgs.fetchFromGitHub {
          "owner" = "dracula";
          "repo" = "sublime";
          "rev" = "d490b57c08f3d110ff61a07ec6edcc1ed9e24a63";
          "hash" = "sha256-7veVVrLPW3T7KkkelDmgPW5kp+b12naKSKwCXBgjL1k=";
        };
        file = "Dracula.tmTheme";
      };

      catppuccin-mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };

    };

  };
}
