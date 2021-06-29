# This is my configuration for a development machine
# 
# Generally this includes an editor, compilers, every scripting language ever, and a bunch of tools.
#
#
#
{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/alacritty
    ../modules/fish
    ../modules/emacs
    ../modules/git
    ../modules/python
    ../modules/tmux
    ../modules/scala
    ../modules/direnv
    ../modules/k8s
  ];
}
