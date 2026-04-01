(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (c "https://github.com/tree-sitter/tree-sitter-c")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
	(markdown "https://github.com/ikatyang/tree-sitter-markdown")))

(defun start/install-treesit-grammars ()
  "Install missing treesitter grammars"
  (interactive)
  (dolist (grammar treesit-language-source-alist)
    (let ((lang (car grammar)))
      (unless (treesit-language-available-p lang)
        (treesit-install-language-grammar lang)))))

(add-hook 'after-init-hook #'start/install-treesit-grammars)

(setq major-mode-remap-alist
      '((sh-mode . bash-ts-mod)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
	(js-json-mode . json-ts-mode)
	(yaml-mode . yaml-ts-mode)
	))

(setq treesit-font-lock-level 4)
(provide 'treesitter-setup)
