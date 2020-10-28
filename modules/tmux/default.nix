{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "xterm-256color";
    escapeTime = 0;
  };
}
