;;(use-package transient
;;  :ensure t
;;  :defer
;;  :config
;;  (define-key transient-map (kbd "<escape>") 'transient-quit-one)) ;; Make escape quit magit prompts

(use-package magit
  :ensure t
  :defer
  :custom (magit-diff-refine-hunk (quote all)) ;; Shows inline diff
  :config
  (setopt magit-format-file-function #'magit-format-file-nerd-icons) ;; Magit nerd icons
  )

(provide 'magit-setup)
