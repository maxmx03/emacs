(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(require 'cache-setup)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
			 ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/"))) ;; For Eat Terminal
(package-initialize)

;; Running package-refresh-contents to ensure that Emacs has fetch the MELPA package list
(unless package-archive-contents
  (package-refresh-contents))

(use-package emacs
  :ensure nil
  :config
  (setq inhibit-startup-message t)
  (setq org-clock-sound "~/Músicas/mixkit-on-hold-ringtone-1361.wav")
  (column-number-mode t)
  (global-display-line-numbers-mode t)
  (which-key-mode t)
  (electric-indent-mode nil)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing
  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed
  (setq mouse-wheel-progressive-speed nil)
  (setq scroll-conservatively 10)
  (setq scroll-margin 8)
  (set-face-attribute 'default nil :font "JetBrainsMono NF" :height 160))

(use-package autothemer
  :ensure t
  :config
  (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
  (load-theme 'oxocarbon t))
(use-package command-log-mode
  :ensure t)
(use-package nerd-icons
  :ensure t)
(unless (file-directory-p "~/.org/")
  (make-directory "~/.org/" t))

(require 'general-setup)
(require 'org-setup)
(require 'org-roam-setup)
(require 'vertico-setup)
(require 'corfu-setup)
(require 'treesitter-setup)
(require 'dashboard-setup)
(require 'magit-setup)
(require 'projectile-setup)
(require 'consult-setup)
(require 'dirvish-setup)
(require 'lsp-mode-setup)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
