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
  (setq which-key-separator " → " )
  (electric-indent-mode nil)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing
  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed
  (setq mouse-wheel-progressive-speed nil)
  (setq scroll-conservatively 10)
  (setq scroll-margin 8)
  (scroll-bar-mode 0)
  (setq backup-by-copying t)
  (setq delete-old-versions t)
  (setq version-control t)
  (set-face-attribute 'default nil :font "JetBrainsMono NF" :height 160))

(use-package autothemer
  :ensure t
  :config
  (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
  (load-theme 'oxocarbon t))
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
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
(require 'projectile-setup)
(require 'dashboard-setup)
(require 'magit-setup)
(require 'consult-setup)
(require 'dirvish-setup)

(use-package eglot
  :ensure nil
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (c-ts-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure))
  :config
  (setq eglot-autostart t))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)               
  (corfu-auto-delay 0.3)       
  (corfu-auto-prefix 2)        
  (corfu-cycle t)              
  (corfu-preselect 'prompt)    
  
  :init
  (global-corfu-mode))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package eat
  :ensure t
  :defer
  :hook ('eshell-load-hook #'eat-eshell-mode))

(use-package undo-fu-session
  :ensure t
  :config
  (setq undo-fu-session-directory (expand-file-name "undo-fu-session/" user-emacs-directory))
  (undo-fu-session-global-mode))

(setq undo-limit 67108864)        ; 64mb
(setq undo-strong-limit 100663296) ; 96mb
(setq undo-outer-limit 1006632960) ; 960mb

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(put 'upcase-region 'disabled nil)
