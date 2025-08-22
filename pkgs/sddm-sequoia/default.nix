{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "sddm-theme-sequoia";
  version = "latest"; # or tag

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "Sequoia-sddm";
    rev = "master";
    sha256 = "0scd1qsg2ldrbjwzfpr4i4kgqfm14k983w0igf651qxfpllgnplk";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/sequoia
  '';
}

