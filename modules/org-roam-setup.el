(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/.org/"))
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
      '(
        ("p" "permanent" plain "%?"
         :target (file+head "permanent/%^{Subpasta}/%<%Y%m%d%H%M%S>-${slug}.org" 
                            "#+title: ${title}\n#+filetags: :permanent:\n")
         :unnarrowed t)

        ("l" "literature" plain "%?"
         :target (file+head "literature/%^{Subpasta}/%<%Y%m%d%H%M%S>-${slug}.org" 
                            "#+title: ${title}\n#+filetags: :literature:\n")
         :unnarrowed t)
       
        ("d" "default" plain "%?"
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" 
                            "#+title: ${title}\n")
         :unnarrowed t))))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(provide 'org-roam-setup)
