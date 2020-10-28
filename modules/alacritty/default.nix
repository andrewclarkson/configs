{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      shell.program = "fish";
      shell.args = [
        "-l"
        "-c"
        "tmux"
      ];

      font = {
        size = 13;
        use_thin_strokes = true;
        normal = {
          family = "Source Code Pro";
        };
      };

      colors = {
        primary = {
          background = "0x282c34";
          foreground = "0xbbc2cf";
        };
        cursor = {
          text = "0x44475a";
          cursor = "0xf8f8f2";
        };
        selection = {
          background = "0x3f444a";
        };
        normal = {
          black =   "0x1B2229";
          red =     "0xff6c6b";
          green =   "0x98be65";
          yellow =  "0xECBE7B";
          blue =    "0x51afef";
          magenta = "0xa9a1e1";
          cyan =    "0x5699AF";
          white =   "0x5B6268";
        };
        bright = {
          black =   "0x1c1f24";
          red =     "0xda8548";
          green =   "0x4db5bd";
          yellow =  "0xECBE7B";
          blue =    "0x51afef";
          magenta = "0xc678dd";
          cyan =    "0x46D9FF";
          white =   "0xbbc2cf";
        };
      };
    };
  };
}
