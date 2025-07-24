self: super: {
  xfce = super.xfce // {
    thunar = let
      thunarWithFlags = super.xfce.thunar.overrideAttrs (o: {
        configureFlags = (o.configureFlags or []) ++ [ "--disable-wallpaper-plugin" ];
      });

      package = super.callPackage "${builtins.dirOf super.xfce.thunar.meta.position}/wrapper.nix" {
        thunarPlugins = [];
        thunar = thunarWithFlags;
      };
    in
      package;
  };
}

