{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    plugins = with pkgs.yaziPlugins; {
      chmod = chmod;
      miller = miller;
      restore = restore;
      toggle-pane = toggle-pane;
      full-border = full-border;
      relative-motions = relative-motions;
      sudo = sudo;
    };
    theme = { };
  };
}
