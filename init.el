(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 100000000)
(require 'cache-setup)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Running package-refresh-contents to ensure that Emacs has fetch the MELPA package list
(unless package-archive-contents
  (package-refresh-contents))

(use-package emacs
  :ensure nil
  :config
  (setq inhibit-startup-message t)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (column-number-mode t)
  (global-display-line-numbers-mode t)
  (which-key-mode t)
  (set-face-attribute 'default nil
		      :font "JetBrainsMono NF" 
                      :height 160
                      :weight 'medium)
  (add-to-list 'default-frame-alist '(font . "JetBrainsMono NF-16")))

(use-package autothemer
  :ensure t
  :config
  (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
  (load-theme 'oxocarbon t))

(use-package command-log-mode
  :ensure t)

(use-package nerd-icons
  :ensure t)

(use-package dirvish
  :ensure t
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-attributes
      (append
       ;; The order of these attributes is insignificant, they are always
       ;; displayed in the same position.
       '(vc-state subtree-state nerd-icons collapse)
       ;; Other attributes are displayed in the order they appear in this list.
       '(git-msg file-modes file-time file-size))))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'meow-setup)
(require 'org-setup)
(require 'vertico-setup)
(require 'corfu-setup)
(require 'treesitter-setup)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  ;; Personalização para o seu workflow:
  (setq dashboard-items '((recents  . 5)   ;; 5 arquivos mais recentes
                          (projects . 5)   ;; Seus últimos projetos C++
                          (agenda   . 5))) ;; O que tem pra hoje no Org-mode
  
  ;; Estética (já que você usa nerd-icons)
  (setq dashboard-display-icons-p t) 
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startup-banner '(1 2 3))
  (setq dashboard-banner-logo-title "Success is the sum of small efforts, repeated day in and day out.")
  (setq dashboard-footer-messages
      '(
        "Emacs: An operating system that happens to have a text editor."
        "Opening Emacs is the first step. Closing it is the final boss."
        "Configuring Emacs is not procrastination, it's 'Workflow Engineering'."
        "Your Org-mode habits are watching you. Go study Math!"
	"E.M.A.C.S. - Eight Megabytes And Constantly Swapping (circa 1985)."
        "Emacs is not a religion. It's just the only true way to live."
	"Stop staring at this dashboard and M-x compile your C++ code!"))
  (setq dashboard-set-navigator t))
