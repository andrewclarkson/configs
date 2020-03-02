;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; Install 'use-package' if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))

;; Configure use-package to always ensure and defer
(setq use-package-always-ensure t
      use-package-always-defer t)

;;; System Packages
(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package helm
  :config (helm-mode 1)
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :hook ((rust-mode . lsp)
	 (scala-mode . lsp)))

(use-package projectile)

;;; Language Modes
(use-package idris-mode
  :mode "\\.idr\\'")

(use-package scala-mode
  :mode "\\.s\\(c\\|bt\\|cala\\)$")

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package nix-mode
  :mode "\\.nix\\'")

;; TRAMP configuration for remote file editing
(setq tramp-default-method "ssh")
