{ config, lib, pkgs, ... }:
with pkgs;
let

nixEnv = runCommand "nix-env.el" {
  inherit git ripgrep gnuplot;
} "substituteAll ${./nix-env.el.in} $out";
defaultEl = ../../config/emacs/default.el;
snippets = ../../config/emacs/snippets;
emacsEnv = runCommand "site-lisp" {} ''
  mkdir -p $out/share/emacs/site-lisp
  cp ${nixEnv} $out/share/emacs/site-lisp/nix-env.el
  cp ${defaultEl} $out/share/emacs/site-lisp/default.el
  cp -R ${snippets} $out/share/emacs/site-lisp/snippets
'';

in {
  programs.emacs = {
    enable = true;
    overrides = self: super: rec {
      lsp-metals = self.melpaBuild {
        pname   = "lsp-metals";
        ename   = "lsp-metals";
        version = "1.1.0";
        recipe  = builtins.toFile "recipe" ''
            (lsp-metals :fetcher github
                :repo "emacs-lsp/lsp-metals")
        '';

        packageRequires = [ self.emacs self.lsp-mode ];

        src = fetchFromGitHub {
            owner  = "emacs-lsp";
            repo   = "lsp-metals";
            rev    = "8f8471ca1b2a3d54bafce8949e6b13c9567d0405";
            sha256 = "0q3swqkr4kkfzp1fd7g97r2gzp11vcrx51xbywk336mb6ghlshyc";
        };
      };
    };
    extraPackages = epkgs:
      let
        melpaPkgs = (with epkgs.melpaPackages; [
        counsel
        counsel-projectile
        dap-mode
        doom-modeline
        doom-themes
        evil
        evil-collection
        evil-magit
        flycheck
        general
        ivy
        lsp-ivy
        lsp-mode
        lsp-metals
        lsp-treemacs
        lsp-ui
        magit
        nix-mode
        projectile
        rainbow-delimiters
        sbt-mode
        scala-mode
        smartparens
        treemacs
        treemacs-evil
        treemacs-magit
        treemacs-projectile
        use-package
        vterm
        which-key
        lsp-metals
        yasnippet
        ]);
        systemPkgs = [
          git
          gnuplot
          ripgrep
          metals
          emacs-all-the-icons-fonts
          source-code-pro
          source-sans-pro
          emacsEnv
        ];
      in melpaPkgs ++ systemPkgs;
    package = emacsUnstable;
  };
}
