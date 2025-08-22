{
  spicetify-nix,
  pkgs,
  ...
}:
{
  programs.spicetify =
    let
      spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.bloom;
      # theme = spicePkgs.themes.turntable;

      # colorScheme = "Base";
      colorScheme = "darkgreen";
    };
}
