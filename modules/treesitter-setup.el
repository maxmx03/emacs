(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")))
(defun start/install-treesit-grammars ()
  "Install missing treesitter grammars"
  (interactive)
  (dolist (grammar treesit-language-source-alist)
    (let ((lang (car grammar)))
      (unless (treesit-language-available-p lang)
        (treesit-install-language-grammar lang)))))

(add-hook 'after-init-hook #'start/install-treesit-grammars)

(setq major-mode-remap-alist
      '((sh-mode . bash-ts-mode)))

(setq treesit-font-lock-level 3)
(provide 'treesitter-setup)
