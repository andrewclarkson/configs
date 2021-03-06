{ pkgs ? import <nixpkgs> {} }:

let 
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
    # site-isp
    flycheck
    vterm
    which-key
    magit
    nix-mode
    use-package
  ]) ++ [
    pkgs.ripgrep
  ])
