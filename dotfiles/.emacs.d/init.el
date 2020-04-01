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
(require 'use-package)

;; Configure use-package to always ensure and defer
(setq use-package-always-ensure t
      use-package-always-defer t)

;; Keep auto save stuff out of source code directories
(setq backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;;; System Packages
(use-package magit
  :config (with-editor-emacsclient-executable "emacsclient")
  :bind (("C-x g" . magit-status)))

(use-package helm
  :config (helm-mode 1)
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)))

(use-package helm-ag
  :bind (("C-u" . helm-ag)))

(use-package projectile)

;;; Language Modes
(use-package idris-mode
  :mode "\\.idr\\'")

(use-package scala-mode
  :mode "\\.s\\(c\\|bt\\|cala\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package yaml-mode
  :mode "\\.y\\(ml\\|aml\\)$")


(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :hook ((rust-mode . lsp)
	 (scala-mode . lsp)
	 (lsp-mode . lsp-lens-mode))
  :config (setq lsp-prefer-flymake nil))


;; Enable nice rendering of documentation on hover
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals
(use-package company-lsp)

;; Use the Tree View Protocol for viewing the project structure and triggering compilation
(use-package lsp-treemacs
  :config
  (lsp-metals-treeview-enable t)
  (setq lsp-metals-treeview-show-when-views-received t)
  )


;; TRAMP configuration for remote file editing
(setq tramp-default-method "ssh")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (sbt-mode lsp-treemacs company-lsp yasnippet lsp-ui yaml-mode helm-ag nix-mode rust-mode scala-mode idris-mode projectile lsp-mode flycheck helm magit use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
