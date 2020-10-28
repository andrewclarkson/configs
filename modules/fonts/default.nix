{ config, lib, pkgs, ... }:

{ 
  fonts.fonts = with pkgs; [
    source-code-pro
    source-sans-pro
  ];
}
