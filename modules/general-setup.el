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
  "f" 'word-search-forward
  "F" 'word-search-backward
  "r" 'consult-buffer
  "g" 'end-of-buffer
  "G" 'beginning-of-buffer
  "m" 'mark-word
  "v" 'set-mark-command
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
  "M-<down>" 'org-drag-line-forward)

(define-minor-mode my-normal-mode
  "Change to normal mode"
  :lighter " [NORMAL]"
  :keymap my-normal-mode-map
  (if my-normal-mode
      (progn
        (setq cursor-type 'box)
        (message "[NORMAL]"))
    (progn
      (setq cursor-type 'bar)
      (message "[INSERT]"))))

(defun my-exit-normal-mode ()
  (interactive)
  (my-normal-mode -1)
  (message "[INSERT]"))

(defun my/smart-esc ()
  "ESC: cancel things or enter normal mode"
  (interactive)
  (cond
   ((region-active-p) (deactivate-mark))
   ((window-minibuffer-p) (abort-recursive-edit))
   (t (my-normal-mode 1))))

(defun new-line-below ()
  "Insert new line below cursor"
  (interactive)
  (end-of-line)
  (newline-and-indent)    
  (my-exit-normal-mode))

(defun new-line-above ()
  "Insert new line above cursor"
  (interactive)
  (read-only-mode -1)
  (beginning-of-line)
  (open-line 1)
  (my-exit-normal-mode))

(global-set-key (kbd "<escape>") #'my/smart-esc)

(add-hook 'prog-mode-hook #'my-normal-mode)
(add-hook 'org-mode-hook #'my-normal-mode)
(add-hook 'text-mode-hook #'my-normal-mode)

(use-package multiple-cursors
  :ensure t
  :bind (("C-c d" . mc/mark-all-like-this))
  :config
  (add-hook 'multiple-cursors-mode-enabled-hook 'my-exit-normal-mode)
  (add-hook 'multiple-cursors-mode-disabled-hook 'my-normal-mode))

(provide 'general-setup)
