{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  vscode-generic,
}:

let
  version = "1.4.2";
  pname = "cursor";

  src = fetchurl {
    url = "https://downloads.cursor.com/production/d01860bc5f5a36b62f8a77cd42578126270db343/linux/x64/Cursor-1.4.2-x86_64.AppImage";
    hash = "0hg099qmxhn7caqgc93bqqqf3vk8f662q1cypa9w99f053841ijq";
  };
in

vscode-generic {
  inherit pname version;

  vscodeVersion = "1.102.3";
  executableName = "cursor";
  longName = "Cursor";
  shortName = "cursor";
  libraryName = "cursor";
  iconName = "cursor";

  src = appimageTools.extract {
    inherit pname version src;
  };

  sourceRoot = "${pname}-${version}-extracted/usr/share/cursor";
  useVSCodeRipgrep = false;
  commandLineArgs = "--update=false";

  patchVSCodePath = false;

  meta = {
    description = "AI-powered code editor built on VSCode";
    homepage = "https://cursor.com";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "cursor";
  };
}
