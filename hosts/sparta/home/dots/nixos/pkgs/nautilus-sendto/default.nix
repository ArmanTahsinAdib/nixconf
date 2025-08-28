{
  lib,
  stdenv,
  fetchgit,
  meson,
  ninja,
  pkg-config,
  glib,
  gobject-introspection,
  appstream-glib,
  python3,
}:

stdenv.mkDerivation rec {
  pname = "nautilus-sendto";
  version = "3.8.6+28+gc87aac4";

  src = fetchgit {
    url = "https://gitlab.gnome.org/Archive/nautilus-sendto.git";
    rev = "c87aac46c4893e09b1ced1cca8bb86b0a6823124";
    sha256 = "sha256-TOEhoLujowzXAs/33vbe39nXVg+j1cL1nMPXX6ipLSU=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
    appstream-glib
    python3
  ];

  buildInputs = [
    glib
  ];

  # Patch like in PKGBUILD to fix Meson 0.61+ build
  postPatch = ''
    sed -i -z "s/'appdata',\\n\\s\\+//" src/meson.build
  '';

  mesonFlags = [ ];

  meta = with lib; {
    description = "Easily send files via mail";
    homepage = "https://gitlab.gnome.org/Archive/nautilus-sendto";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
