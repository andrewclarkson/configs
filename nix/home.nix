{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  
  home.file = {
    ".config" = {
      source = ../dotfiles/.config;
      recursive = true;  
    };
  };
}
