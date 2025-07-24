{ config, pkgs, ... }:

{
  imports =
    [ ./zsh.nix ./kitty.nix ./tmux.nix ./fzf.nix ./yazi.nix ./btop.nix ];
}
