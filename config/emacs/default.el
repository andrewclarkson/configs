(require 'package)
(package-initialize 'noactivate)
(eval-when-compile (require 'use-package))

(setq use-package-always-ensure nil
      use-package-ensure-function 'ignore
      package-enable-at-startup nil
      package--init-file-ensured t)

(load "nix-env")

(setq gc-cons-threshold 10000000)

(add-hook 'after-init-hook
            (lambda ()
              (setq gc-cons-threshold 1000000)
              (message "gc-cons-threshold restored to %S"
                       gc-cons-threshold)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(set-fringe-mode 10)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(set-face-attribute 'default nil :font "Source Code Pro" :height 120)
(set-face-attribute 'variable-pitch nil :family "Source Sans 3" :height 180)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(column-number-mode)
(global-display-line-numbers-mode t)

(setq-default fill-column 80)

(setq inhibit-startup-screen t)

(setq inhibit-startup-echo-area-message t)

(blink-cursor-mode -1)

(setq blink-matching-paren nil)

(setq x-stretch-cursor nil)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil
  :custom
  ((evil-want-integration t) ;; This is optional since it's already set to t by default.
   (evil-want-keybinding nil))
  :config
  (evil-mode 1))

(defun swap-tns (modes keymaps)
  (evil-collection-swap-key modes keymaps
    "t" "j"
    "n" "k"
    "s" "l"))

(defun swap-tns-control (modes keymaps)
  (evil-collection-swap-key modes keymaps
    (kbd "C-t") (kbd "C-j")
    (kbd "C-n") (kbd "C-k")
    (kbd "C-s") (kbd "C-l")))

(defun dvorak-translation (_mode mode-keymaps &rest _rest)
  (swap-tns '(normal motion emacs) mode-keymaps))

(use-package evil-collection
  :after evil
  :hook (evil-collection-setup-hook . dvorak-translations)
  :init (evil-collection-init)
  :config
    (swap-tns nil '(evil-normal-state-map evil-motion-state-map))
    (swap-tns-control nil '(evil-normal-insert-map)))

(use-package general
 :config 
 :init
 (general-override-mode)
  (general-create-definer define-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

(use-package which-key
  :diminish
  :init (which-key-mode)
  :custom ((which-key-idle-delay 1)))

(use-package ivy
  :diminish
  :init (ivy-mode)
  :bind (:map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-s" . ivy-alt-done)
         ("C-t" . ivy-next-line)
         ("C-n" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-n" . ivy-previous-line)
         ("C-s" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-n" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill)))

(use-package counsel)
(define-keys
    "f" '(:ignore t :which-key "files")
    "ff" '(counsel-find-file :which-key "find file")
    ":" '(counsel-M-x :which-key "execute")
    "b" '(:ignore t :which-key "buffers")
    "bb" '(projectile-switch-to-buffer :which-key "switch buffer")
    "bB" '(counsel-ibuffer :which-key "switch buffer (all)")
    "bd" '(kill-current-buffer :which-key "kill current buffer"))

(defun org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (display-line-numbers-mode -1)
  (setq evil-auto-indent nil))

(use-package org
  :hook (org-mode . org-mode-setup)
  :config
    (setq org-hide-emphasis-markers t
	org-src-fontify-natively t
	org-src-tab-acts-natively t
	org-edit-src-content-indentation 0
	org-hide-block-startup nil
	org-src-preserve-indentation nil
	org-startup-folded 'content
	org-cycle-separator-lines 2)

    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
        (set-face-attribute (car face) nil :height (cdr face)))

    ;; Make sure org-indent face is available
    (require 'org-indent)

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org-capture
  :config 
    (setq org-capture-templates '(
       ("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks") "* TODO %i%?")
       ("r" "Reference" entry (file+headline "~/org/reference.org" "References") "* %i%? \n %U"))))

(define-keys
    "o" '(:ignore t :which-key "org mode")
    "oa" '(org-agenda :which-key "org agenda")
    "oc" '(org-capture :which-key "capture")
    "oi" '(:ignore t :which-key "insert")
    "oil" '(org-agenda :which-key "link")
    "ob" '(:ignore t :which-key "babel")
    "obt" '(org-babel-tangle :which-key "tangle"))

(setq org-refile-targets '(("~/org/gtd.org" :maxlevel . 3)
                           ("~/org/someday.org" :level . 1)
                           ("~/org/reference.org" :maxlevel . 2)))

(setq org-agenda-files '(
  "~/org/inbox.org"
  "~/org/gtd.org"
  "~/org/reference.org"))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))

(use-package yasnippet
  :config 
    (yas-global-mode 1)
    (setq yas-snippet-dirs '("./snippets")))

(winner-mode t)

(define-keys 
  "w" '(:ignore t :which-key "windows")
  "ww" '(other-window :which-key "other window")
  "wm" '(:ignore t :which-key "move")
  "wmm" '(maximize-window :which-key "maximize current window")
  "wmn" '(windmove-up :which-key "move window focus up") 
  "wmt" '(windmove-down :which-key "move window focus down") 
  "wmh" '(windmove-left :which-key "move window focus left") 
  "wms" '(windmove-right :which-key "move window focus right") 
  "ws" '(:ignore t :which-key "split")
  "wsv" '(evil-window-vsplit :which-key "split vertically")
  "wsh" '(evil-window-split :which-key "split horizontally")
  "wd" '(:ignore t :which-key "delete")
  "wdo" '(evil-window-delete :which-key "delete other windows")
  "wdd" '(evil-window-delete :which-key "delete current window"))

(use-package projectile
  :custom 
  ((projectile-completion-system 'ivy)
   (projectile-project-search-path '("~/Code")))
  :init (projectile-mode))

(define-keys
    "p" 'projectile-command-map
    "pa" 'projectile-add-known-project)

(use-package counsel-projectile
  :init (counsel-projectile-mode))

(define-keys
  "ps" '(counsel-projectile-rg :which-key "search project")
  "SPC" '(counsel-projectile-find-file-dwim :which-key "find project file"))

(use-package magit)

(define-keys
    "gg" 'magit-status
    "gc" 'magit-clone)

(use-package evil-magit
  :after evil magit
  :config
  (evil-define-key evil-magit-state magit-mode-map "t" 'evil-next-visual-line)
  (evil-define-key evil-magit-state magit-mode-map "n" 'evil-previous-visual-line))

(evil-define-key '(normal visual motion) dired-mode-map "t" 'dired-next-line)

(use-package treemacs)

(use-package treemacs-projectile
  :after treemacs projectile)

(use-package treemacs-magit
  :after treemacs magit)

(use-package treemacs-evil
  :after treemacs evil)

(define-keys 
    "tt" 'treemacs)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-lens-mode)))

(use-package lsp-ui
   :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package dap-mode
  :hook ((lsp-mode . dap-mode)
         (lsp-mode . dap-ui-mode)))

(use-package scala-mode)

(use-package sbt-mode)

(use-package lsp-metals
  :hook (scala-mode . lsp))

(use-package vterm
  :config 
    (display-line-numbers-mode -1))
