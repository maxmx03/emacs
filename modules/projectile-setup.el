(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-project-search-path '(("~/Desenvolvimento/" . 1)
                                         ("~/.org/" . 1)
                                         "~/.config/emacs/")))

(provide 'projectile-setup)
