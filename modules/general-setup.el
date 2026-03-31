(defvar-keymap my-expand-mode-map
  :doc "Keybinds for Expand Mode."
  "w" 'er/mark-word
  "q" 'er/mark-inside-quotes
  "Q" 'er/mark-outside-quotes
  "p" 'er/mark-inside-pairs
  "P" 'er/mark-outside-pairs
  "c" 'er/mark-comment
  "u" 'er/mark-url
  "d" 'er/mark-defun
  "f" 'er/mark-method-call
  "t" 'er/mark-inner-tag
  "T" 'er/mark-outer-tag
  "a" 'er/mark-html-attribute)

(defvar-keymap my-normal-mode-map
  :doc "Keybindings for Normal Mode."
  ;;"l" 'forward-char
  ;;"h" 'backward-char
  ;;"j" 'next-line
  ;; "k" 'previous-line
  "o" 'new-line-below
  "O" 'new-line-above
  "a" 'beginning-of-line
  "A" 'end-of-line
  "e" 'end-of-line
  "E" 'beginning-of-line
  "0" 'beginning-of-line
  "$" 'end-of-line
  "w" 'right-word
  "W" 'left-word
  "y" 'kill-ring-save
  "u" 'undo
  "U" 'undo-redo
  "q" 'kill-current-buffer
  "f" 'search-forward
  "F" 'search-backward
  "r" 'consult-buffer
  "g" 'end-of-buffer
  "G" 'beginning-of-buffer
  "m" 'mark-word
  "v" 'set-mark-command
  "V" 'my-expand-mode
  "k" 'kill-line
  "K" 'kill-sentence
  "x" 'execute-extended-command
  "s" 'save-buffer
  "d" 'kill-word
  "D" 'backward-kill-word
  "c" 'delete-char
  "C" 'backward-delete-char
  "C-d" 'mc/mark-all-like-this
  "i" 'my-exit-normal-mode
  ";" 'comment-line
  "M-<up>" 'org-drag-line-backward
  "M-<down>" 'org-drag-line-forward
  "n" 'dired)

(use-package expand-region :ensure t)
(use-package multiple-cursors
  :ensure t
  :config
  (add-hook 'multiple-cursors-mode-enabled-hook #'my-exit-normal-mode)
  (add-hook 'multiple-cursors-mode-disabled-hook #'my-enter-normal-mode))

(define-minor-mode my-normal-mode
  "Command state (Neovim style)."
  :lighter " [NORMAL]"
  :keymap my-normal-mode-map
  (if my-normal-mode
      (progn
        (my-expand-mode -1)
        (setq cursor-type 'box)
        (message "[NORMAL]"))
    (unless (or my-normal-mode my-expand-mode)
      (setq cursor-type 'bar)
      (message "[INSERT]"))))

(define-minor-mode my-expand-mode
  "State of visual selection."
  :lighter " [EXPAND]"
  :keymap my-expand-mode-map
  (if my-expand-mode
      (progn
        (my-normal-mode -1)
        (setq cursor-type '(hbar . 7))
        (message "[EXPAND]"))
    (unless (or my-normal-mode my-expand-mode)
      (setq cursor-type 'bar)
      (message "[INSERT]"))))

(defun my-enter-normal-mode ()
  "Activates normal mode and clears selections."
  (interactive)
  (deactivate-mark)
  (my-normal-mode 1))

(defun my-exit-normal-mode ()
  "Exit all modal modes and return to the default insertion mode."
  (interactive)
  (my-expand-mode -1)
  (my-normal-mode -1)
  (setq cursor-type 'bar)
  (message "[INSERT]"))

(defun my/smart-esc ()
  "The maestro of navigation: always trying to bring you back to NORMAL."
  (interactive)
  (cond
   ((window-minibuffer-p) (abort-recursive-edit))
   ((or my-expand-mode (region-active-p)) (my-enter-normal-mode))
   (t (my-enter-normal-mode))))

(defun new-line-below ()
  "Open a new line below and enter insert mode."
  (interactive)
  (end-of-line)
  (newline-and-indent)    
  (my-exit-normal-mode))

(defun new-line-above ()
  "Open a new line above and enter insert mode."
  (interactive)
  (read-only-mode -1)
  (beginning-of-line)
  (open-line 1)
  (my-exit-normal-mode))

(global-set-key (kbd "<escape>") #'my/smart-esc)

(dolist (hook '(prog-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook #'my-normal-mode))

(provide 'general-setup)
