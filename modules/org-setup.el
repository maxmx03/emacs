(use-package org
  :ensure nil
  :custom
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers t)
  (org-log-done 'time)
  :config
  (set-face-attribute 'org-level-1 nil :height 1.2 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'bold))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇" "✳")))

(provide 'org-setup)
