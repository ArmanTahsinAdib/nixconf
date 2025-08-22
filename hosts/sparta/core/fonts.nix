{ pkgs, ... }:

let
  solaimanlipi = pkgs.stdenv.mkDerivation {
    pname = "SolaimanLipi";
    version = "2020-04-07";

    src = pkgs.fetchurl {
      url = "https://www.omicronlab.com/download/fonts/SolaimanLipi_20-04-07.ttf";
      sha256 = "1riglaa00az6qw8d30w55zgcka2fcwisjd5bag7qzaqd2kqg9fqn";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/fonts/TTF
      cp $src $out/share/fonts/TTF/
    '';
  };
in
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      google-fonts
      corefonts
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
      lohit-fonts.bengali
      solaimanlipi
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "SolaimanLipi"
          "Noto Serif"
        ];
        sansSerif = [ "Noto Sans Bengali" ];
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };
}
