;; -*- lexical-binding: t; -*-

(defun start/org-babel-tangle-config ()
  "Automatically tangle init.org config and refresh package-quickstart"
  (interactive)
  (when (string-equal (file-name-directory (buffer-file-name))
		      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle)
      (package-quickstart-refresh))))

(add-hook 'org-mode-hook (lambda ()
			   (add-hook 'after-save-hook #'start/org-babel-tangle-config)))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(setq package-quickstart t) ;; For blazingly fast startup times, this line makes startup miles faster

(defun insert-prev-line ()
  "Enter insert mode in previous line"
  (interactive)
  (move-beginning-of-line 1)
  (open-line 1)
  (enable-insert-mode))

(defun insert-new-line ()
  "Enter insert mode in new line"
  (interactive)
  (move-end-of-line 1)
  (open-line 1)
  (next-line 1)
  (enable-insert-mode))

(defvar-keymap nrm-map
  :doc "keymap for normal mode"
  "w" 'forward-word
  "b" 'backward-word
  "x" 'delete-char
  "d" 'kill-word
  "p" 'yank
  "k" 'kill-line
  "K" 'kill-whole-line
  "a" 'move-beginning-of-line
  "e" 'move-end-of-line
  "D" 'kill-region
  "y" 'kill-ring-save
  "m w" 'mark-word
  "m p" 'mark-paragraph
  "m d" 'mark-defun
  "m s" 'mark-end-of-sentence
  "m b" 'mark-whole-buffer
  "v" 'set-mark-command
  "i" 'enable-insert-mode
  "o" 'insert-new-line
  "O" 'insert-prev-line
  "0" 'delete-window
  "1" 'delete-other-windows
  "s v" 'split-window-below
  "s s" 'split-window-right
  "g g" 'goto-line
  "g c" 'goto-char
  "<" 'beginning-of-buffer
  ">" 'end-of-buffer
  "'" 'other-window
  "C-d" 'scroll-up-command
  "C-e" 'scroll-down-command
  "/" 'undo
  "?" 'undo-redo
  "r" 'list-buffers
  "M-<up>" 'org-drag-line-backward
  "M-<down>" 'org-drag-line-forward
  "\\" 'comment-line
  "l" 'recenter-top-bottom
  "; e" 'dired
  "n s" 'org-narrow-to-subtree
  "n w" 'widen
)

(define-minor-mode normal-minor-mode
  "Normal mode"
  :lighter " [NORMAL]"
  :keymap nrm-map
   (setq cursor-type 'box))

(define-minor-mode insert-minor-mode
  "Insert mode"
  :lighter " [INSERT]"
  :keymap nil
  (setq cursor-type 'bar))

(defun enable-insert-mode ()
   "Enable Insert Mode"
   (interactive)
   (normal-minor-mode -1)
   (insert-minor-mode 1))

(defun enable-normal-mode ()
  "Enable Normal mode"
  (interactive)
  (insert-minor-mode -1)
  (normal-minor-mode 1))

(use-package emacs
  :init
  ;; 1. Desativar elementos de UI antes de carregar a interface (evita "flicker")
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  ;; 2. Ativar modos globais
  (global-display-line-numbers-mode t)
  (global-hl-line-mode t)
  (electric-pair-mode t)
  (global-auto-revert-mode t)

  ;; 3. Configuração de Fonte
  (set-frame-font "JetBrainsMono NF Medium 14" nil t)

  ;; 4. Criar diretórios de backup de forma segura
  (let ((backup-dir "~/.cache/emacs/backup/")
        (auto-save-dir "~/.cache/emacs/auto-save/"))
    (dolist (dir (list backup-dir auto-save-dir))
      (when (not (file-directory-p dir))
        (make-directory dir t))))

  :custom
  ;; 5. Variáveis puras de customização
  (mouse-wheel-progressive-speed nil)
  (scroll-conservatively 10)
  (scroll-margin 8)
  (use-short-answers t)
  
  ;; Backups e Auto-save
  (backup-directory-alist '(("." . "~/.cache/emacs/backup/")))
  (auto-save-file-name-transforms '((".*" "~/.cache/emacs/auto-save/" t)))
  (backup-by-copying t)
  (version-control nil)
  (delete-old-versions t)

  ;; Dired e Org (Variáveis globais do Emacs)
  (dired-kill-when-opening-new-dired-buffer t)
  (org-log-done 'time)
  (org-capture-templates
   '(("t" "Todo" entry (file+headline "~/Documentos/org/task.org") "* TODO %?\n %i\n %a")
     ("j" "Journal" entry (file+datetree "~/Documentos/org/journal.org") "* %?\nEntered on %U\n %i\n %a")))

  ;; 6. Seus ganchos e atalhos corrigidos
  :hook ((prog-mode org-mode text-mode) . enable-normal-mode)
  :bind ("<escape>" . enable-normal-mode))

(use-package moe-theme
  :config
  (add-to-list 'default-frame-alist '(alpha-background . 95))
  (load-theme 'moe-dark t))

(use-package undo-fu-session
  :config
  (setq undo-fu-session-directory (expand-file-name "undo-fu-session/" user-emacs-directory))
  (setq undo-limit 67108864)        ; 64mb
  (setq undo-strong-limit 100663296) ; 96mb
  (setq undo-outer-limit 1006632960) ; 960mb
  (undo-fu-session-global-mode))

(use-package org-superstar
    :after org
    :hook (org-mode . org-superstar-mode))

(keymap-global-set "C-c l" #'org-store-link)
(keymap-global-set "C-c a" #'org-agenda)
(keymap-global-set "C-c c" #'org-capture)
(keymap-global-set "C-c o" #'dashboard-open)

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-project-search-path '(("~/Github/" . 1)
                                         "~/.config/emacs/")))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda   . 5)))
  
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-display-icons-p t) 
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
