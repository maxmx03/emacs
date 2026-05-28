(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(use-package autothemer
  :ensure t
  :config
  (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
  (load-theme 'oxocarbon t))

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

(use-package undo-fu-session
  :ensure t
  :config
  (setq undo-fu-session-directory (expand-file-name "undo-fu-session/" user-emacs-directory))
  (undo-fu-session-global-mode))

(setq undo-limit 67108864)        ; 64mb
(setq undo-strong-limit 100663296) ; 96mb
(setq undo-outer-limit 1006632960) ; 960mb

(global-display-line-numbers-mode t)
(which-key-mode t)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(set-frame-font "JetBrainsMono NF Medium 14" nil t)
(let ((backup-dir "~/.cache/emacs/backup/")
      (auto-save-dir "~/.cache/emacs/auto-save/"))
  (dolist (dir (list backup-dir auto-save-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t))))
(setq backup-directory-alist '(("." . "~/.cache/emacs/backup/"))
      auto-save-file-name-transforms '((".*" "~/.cache/emacs/auto-save/" t))
      backup-by-copying t
      version-control nil
      delete-old-versions t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq mouse-wheel-progressive-speed nil)
(setq scroll-conservatively 10)
(setq scroll-margin 8)
(setq org-log-done 'time)

(keymap-global-set "C-c l" #'org-store-link)
(keymap-global-set "C-c a" #'org-agenda)
(keymap-global-set "C-c c" #'org-capture)
(keymap-global-set "C-c o" #'dashboard-open)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "a") 'dired-create-empty-file)
  (define-key dired-mode-map (kbd "A") 'dired-create-directory)
  (define-key dired-mode-map (kbd "f") 'dired-find-file))

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
  (enable-insert-mode)
  )

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

(keymap-global-set "<escape>" 'enable-normal-mode)
(dolist (hook '(prog-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook (lambda ()
	      (when (display-graphic-p)
	      (electric-pair-mode)
	      (global-completion-preview-mode)
	      (enable-normal-mode)))))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
