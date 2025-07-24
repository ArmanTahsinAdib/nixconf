{ stdenv, grub, jetbrains-mono-nerd, size ? 36 }:

stdenv.mkDerivation {
  pname = "jetbrainsmono-pf2";
  version = "1.0";

  buildInputs = [ grub ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/grub/fonts
    ${grub}/bin/grub-mkfont \
      --size=${toString size} \
      --output=$out/share/grub/fonts/JetBrainsMonoNerdFont.pf2 \
      ${jetbrains-mono-nerd}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFont-Regular.ttf
  '';
}

