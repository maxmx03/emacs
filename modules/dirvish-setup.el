(use-package dirvish
  :ensure t
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-attributes
      (append
       ;; The order of these attributes is insignificant, they are always
       ;; displayed in the same position.
       '(vc-state subtree-state nerd-icons collapse)
       ;; Other attributes are displayed in the order they appear in this list.
       '(git-msg file-modes file-time file-size))))

(provide 'dirvish-setup)
