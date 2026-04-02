(use-package projectile
  :ensure t
  :hook (after-init . projectile-mode)
  :config
  (projectile-mode)
  :custom
  ;; (projectile-auto-discover nil) ;; Disable auto search for better startup times ;; Search with a keybind
  (projectile-run-use-comint-mode t) ;; Interactive run dialog when running projects inside emacs (like giving input)
  (projectile-switch-project-action #'projectile-dired) ;; Open dired when switching to a project
  (projectile-project-search-path '("~/.org/" ))) ;; . 1 means only search the first subdirectory level for projects

(provide 'projectile-setup)
