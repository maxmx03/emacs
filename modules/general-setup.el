(use-package expand-region :ensure t)
(use-package multiple-cursors
  :ensure t
  :config
  (add-hook 'multiple-cursors-mode-enabled-hook #'insert-mode)
  (add-hook 'multiple-cursors-mode-disabled-hook #'normal-mode))

(defun insert-nextline ()
  "Enter insert mode nextline"
  (interactive)
  (end-of-line)
  (newline-and-indent)
  (insert-mode))

(defun insert-prevline()
  "Enter insert mode prevline"
  (interactive)
  (beginning-of-line)
  (open-line 1)
  (insert-mode))

(defun copy-line ()
  (interactive)
  (save-excursion
    (kill-ring-save (line-beginning-position) (line-end-position))))

(defvar-keymap normal-mode-map
  :doc "keybinds for normal mode"
  "1" 'delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "'" 'other-window
  "0" 'delete-window
  "@" 'set-mark-command
  "a" 'move-beginning-of-line
  "A" 'backward-sentence
  "b" 'backward-word
  "d" 'delete-char
  "e" 'move-end-of-line
  "E" 'forward-sentence
  "f" 'forward-word
  "g" 'end-of-buffer
  "G" 'beginning-of-buffer
  "j" 'electric-newline-and-maybe-indent
  "k" 'kill-whole-line
  "l" 'recenter-top-bottom
  "n" 'next-line
  "o" 'insert-nextline
  "O" 'insert-prevline
  "q" 'quoted-insert
  "r" 'isearch-backward
  "s" 'isearch-forward
  "i" 'insert-mode
  "u" 'redo
  "/" 'undo
  "w" 'kill-region
  "y" 'kill-ring-save
  "Y" 'copy-line
  "p" 'yank
  "\\" 'comment-line
  "x" 'execute-extended-command
  "c" 'kill-ring-save
  "C-d" 'mc/mark-next-like-this
  "m w" 'mark-word
  "m p" 'mark-paragraph
  "m q" 'er/mark-inside-quotes
  "m (" 'er/mark-inside-pairs
  "m d" 'mark-defun
  "m m" 'er/mark-method-call
  "m t" 'er/mark-inner-tag
  "SPC" 'set-mark-command)

(define-minor-mode insert-minor-mode
  "Enter insert mode, user can edit file"
  :lighter " [INSERT]"
  :keymap nil
  (if insert-minor-mode
      (setq cursor-type 'bar)
    (setq cursor-type 'box)))

(define-minor-mode normal-minor-mode
  "Command state"
  :lighter " [NORMAL]"
  :keymap normal-mode-map
  (if normal-minor-mode
      (setq cursor-type 'box)
    (setq cursor-type 'bar)))

(defun insert-mode ()
  "Enter insert mode"
  (interactive)
  (insert-minor-mode 1)
  (normal-minor-mode -1))

(defun my/smart-esc ()
  "Return to NORMAL mode"
  (interactive)
  (normal-minor-mode 1)
  (insert-minor-mode -1))

(global-set-key (kbd "<escape>") #'my/smart-esc)

(defvar-keymap my-org-roam-map
  :doc "Atalhos para o Zettelkasten."
  "f" 'org-roam-node-find
  "i" 'org-roam-node-insert
  "c" 'org-roam-capture
  "g" 'org-roam-ui-mode
  "t" 'org-capture)

(keymap-set normal-mode-map ";" my-org-roam-map)

(dolist (hook '(prog-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook #'normal-minor-mode))

(provide 'general-setup)
