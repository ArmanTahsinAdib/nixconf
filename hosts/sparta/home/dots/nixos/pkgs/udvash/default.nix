{
  stdenv,
  lib,
  fetchurl,
  makeWrapper,
  nss,
  libXss,
  libXtst,
  at-spi2-atk,
  alsaLib,
  gtk3,
  gconf,
  glib,
  libnotify,
  ffmpeg,
}:

stdenv.mkDerivation rec {
  pname = "udvash-unmesh";
  version = "1.0.0";

  src = fetchurl {
    url = "https://ums-cdn.udvash-unmesh.com/ums-cdn/DesktopApp/Production/Linux/Udvash-Unmesh-v1.0.0.zip";
    sha256 = "0svj42v5p1gi7rc9aj98z7lx3n5mlijr3xpvpvz2k12gcvw6n11v";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildPhase = ''
    mkdir -p $out/opt
    unzip $src -d $out/opt
  '';

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper $out/opt/udvash-unmesh/UdvashUnmeshDesktopAppLinux $out/bin/udvash-unmesh \
      --prefix PATH : ${stdenv.cc.cc}/bin
  '';

  # Runtime dependencies
  propagatedBuildInputs = [
    nss
    libXss
    libXtst
    at-spi2-atk
    alsaLib
    gtk3
    gconf
    glib
    libnotify
    ffmpeg
  ];

  meta = with lib; {
    description = "Udvash Unmesh Desktop App";
    homepage = "https://udvash-unmesh.com";
    license = licenses.mit;
    maintainers = [ ];
  };
}
