(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode c++-mode c-ts-mode c++-ts-mode lua-mode) . lsp-deferred)
  :commands (lsp lsp-deferred)
  :custom

  (lsp-headerline-breadcrumb-enable t)
  (lsp-diagnostics-provider :flymake)
  :config
  (setq lsp-inlay-hint-enable t)
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
 
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t)
 
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-border "white")

  (lsp-ui-imenu-enable t))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(provide 'lsp-mode-setup)
