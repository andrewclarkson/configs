{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    cantarell-fonts # For some firefox sans-serif stuff
  ];

  fonts.enableFontDir = true;

  fonts.fontconfig.defaultFonts = {
    serif = ["Noto Serif"];
    sansSerif = ["Noto Sans"];
    monospace = ["Noto Sans Mono"];
    # emoji = ["Noto Color Emoji"];
  };
} 
