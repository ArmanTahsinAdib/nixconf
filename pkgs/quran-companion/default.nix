{
  appimageTools,
  fetchurl,
  pkgs,
}:
let
  pname = "quran-companion";

  version = "1.3.3";

  meta = {
    description = "Cross-platform desktop Quran reader & player ";
    homepage = "https://0xzer0x.github.io/projects/quran-companion";
    license = pkgs.lib.licenses.gpl3Only;
    maintainers = with pkgs.lib.maintainers; [ arman-adib ];
  };
  src = fetchurl {
    url = "https://github.com/0xzer0x/quran-companion/releases/download/v1.3.3/Quran_Companion-1.3.3-x86_64.AppImage";
    hash = "sha256:5ddb48f78d61d5d7cb27c8869769c9ba220cf331d3747e9aa2df8e6dae93eb1a";
  };

  extraPkgs = pkgs: with pkgs; [ zstd ];
  appimageContents = appimageTools.extractType2 {
    inherit
      pname
      version
      src
      extraPkgs
      meta
      ;
  };
in

appimageTools.wrapType2 {
  inherit
    pname
    version
    src
    extraPkgs
    meta
    ;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/io.github._0xzer0x.qurancompanion.desktop -t $out/share/applications
    install -m 444 -D ${appimageContents}/io.github._0xzer0x.qurancompanion.png -t $out/share/icons/hicolor/512x512/apps
  '';
}
