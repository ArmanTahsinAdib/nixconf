{
  pkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;
    includes = [
      "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/mpv/refs/heads/main/themes/mocha/mauve.conf";
        hash = "sha256-t+TotYyovSKFmLJRx8+XagwgQOBLiEGufom5ni0KkrA=";
      }}"
    ];
  };
}
