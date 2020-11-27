{ config, lib, pkgs, ... }:
with pkgs;
let
  doomSrc = fetchFromGitHub {
    owner  = "hlissner";
    repo   = "doom-emacs";
    rev    = "471028ce94424ded969e959195007080442424bd";
    sha256 = "09v7lbqg3brvyyifrgcs8qvckd7w34dyknx6ivshf3jlval9jffa";
  };
  nixEnv = runCommand "nix-env.el" {
    inherit git ripgrep gnuplot fd;
  } "substituteAll ${./nix-env.el.in} $out";
in {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [emacs git nixEnv];
  };
  home.file.".doom.d" = {
    source = ../../config/doom-emacs;
    recursive = true;  
  };
  home.file.".doom.d/nix-env.el" = {
    source = nixEnv.out;
  };
  home.file.".emacs.d" = {
    source = doomSrc;
    recursive = true;
  };
}
