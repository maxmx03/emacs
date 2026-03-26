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
  (completion-preview-mode)
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
