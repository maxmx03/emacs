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

(use-package multiple-cursors
  :ensure t
  :bind (("C-c d" . mc/mark-all-like-this))
  :config
  (add-hook 'multiple-cursors-mode-enabled-hook 'meow-insert-mode)
  (add-hook 'multiple-cursors-mode-disabled-hook 'meow-normal-mode))

(use-package meow
  :ensure t
  :init
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-kill)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))
  :config
  (meow-setup)
  (meow-global-mode 1))

(use-package org
  :ensure nil
  :custom
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers t)
  (org-log-done 'time)
  :config
  (set-face-attribute 'org-level-1 nil :height 1.2 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'bold))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇" "✳")))


(use-package vertico
  :ensure t
  :bind (:map vertico-map
              ("TAB" . vertico-next)
              ("<backtab>" . vertico-previous)
              ("C-M-v" . vertico-scroll-down)
              ("<right>" . vertico-insert))
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package marginalia
  :ensure t
  :after vertico
  :config
  (marginalia-mode))

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook
  (marginalia-mode . nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))
