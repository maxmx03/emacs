(use-package org
  :ensure nil
  :custom
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers t)
  (org-log-done 'time)
  :config
  (set-face-attribute 'org-level-1 nil :height 1.2 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'bold)

  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("cpp" . "src cpp"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (python . t)
     (emacs-lisp . t)
     (shell . t)))

  (setq org-agenda-files '("~/.org/"))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "DOING(i)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.org/tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %a")))
  
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  
  (setq org-latex-remove-logfiles t)
  (setq org-confirm-bash-evaluate nil
        org-confirm-babel-evaluate nil)
  (setq org-export-with-smart-quotes t
        org-html-htmlize-output-type 'css
        org-latex-listings 'minted
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-packages-alist '("" "minted"))))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-star '("◉" "○" "◈" "◇" "✳")))

(use-package htmlize :ensure t)

(provide 'org-setup)
