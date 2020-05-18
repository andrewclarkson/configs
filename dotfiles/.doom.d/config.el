;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Andrew Clarkson"
      user-mail-address "andrew@clarkson.codes")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Source Code Pro" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(map! :map evil-snipe-override-mode-map
      :m "t" nil)

(map! :map evil-snipe-local-mode-map
      :m "s" nil
      :n "s" nil)

(map! :map evil-snipe-mode-map
      :m "s" nil
      :n "s" nil)

(map! :map evil-snipe-override-local-mode-map
      :m "t" nil)

(map! :map evil-motion-state-map
      "t" 'evil-next-line
      "n" 'evil-previous-line
      "T" 'evil-ex-search-next
      "j" nil
      "k" nil)

(map! :map evil-normal-state-map
      "s" 'evil-forward-char
      "C-t" nil)

(map! :map evil-insert-state-map
      "C-h" 'evil-backward-char
      "C-t" 'evil-next-line
      "C-n" 'evil-previous-line
      "C-s" 'evil-forward-char)

(map! :map Buffer-menu-mode-map
      :n "t" 'evil-next-line
      :n "n" 'evil-previous-line
      :n "j" nil
      :n "k" nil)

(map! :map magit-mode-map
      :nv "t" 'evil-next-line
      "n" 'evil-previous-line
      "j" nil
      "k" nil)

(map! :map evil-ex-completion-map
      "C-h" 'evil-backward-char
      "C-s" 'evil-forward-char)

(map! :map ivy-minibuffer-map
      "C-t" 'ivy-next-line
      "C-n" 'ivy-previous-line
      "C-s" 'ivy-forward-char)

(map! :map 'org-agenda-mode
      :m "t" 'org-agenda-next-line
      :m "n" 'org-agenda-previous-line)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
