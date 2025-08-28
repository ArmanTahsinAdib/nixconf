{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  gettext,
  nautilus-python,
}:

stdenv.mkDerivation rec {
  pname = "nautilus-admin";
  version = "1.1.9";

  src = fetchFromGitHub {
    "owner" = "brunonova";
    "repo" = "nautilus-admin";
    "rev" = "b4cb69f86c87517554923719e95b1ed2618178d8";
    "hash" = "sha256-+KyxQVP+Q0cgR0T1g3JRRZASclBKq9u38XL7vjVUpF4=";
  };

  nativeBuildInputs = [
    cmake
    gettext
  ];

  buildInputs = [ nautilus-python ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=None"
    "-DCMAKE_INSTALL_PREFIX=/usr"
  ];

  buildPhase = ''
    mkdir build
    cd build
    cmake ..
    make
  '';

  installPhase = ''
    cd build
    make DESTDIR=$out install
  '';

  meta = with lib; {
    description = "Nautilus extension to perform administrative operations";
    license = licenses.gpl3Plus;
    homepage = "https://github.com/brunonova/nautilus-admin";
    maintainers = with maintainers; [ ];
  };
}
