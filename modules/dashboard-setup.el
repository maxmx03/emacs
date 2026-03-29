(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  ;; Personalização para o seu workflow:
  (setq dashboard-items '((recents  . 5)   ;; 5 arquivos mais recentes
                          (projects . 5)   ;; Seus últimos projetos C++
                          (agenda   . 5))) ;; O que tem pra hoje no Org-mode
  
  ;; Estética (já que você usa nerd-icons)
  (setq dashboard-display-icons-p t) 
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startup-banner '(1 2 3))
  (setq dashboard-banner-logo-title "Success is the sum of small efforts, repeated day in and day out.")
  (setq dashboard-footer-messages
      '(
        "Emacs: An operating system that happens to have a text editor."
        "Opening Emacs is the first step. Closing it is the final boss."
        "Configuring Emacs is not procrastination, it's 'Workflow Engineering'."
        "Your Org-mode habits are watching you. Go study Math!"
	"E.M.A.C.S. - Eight Megabytes And Constantly Swapping (circa 1985)."
        "Emacs is not a religion. It's just the only true way to live."
	"Stop staring at this dashboard and M-x compile your C++ code!"))
  (setq dashboard-set-navigator t))

(provide 'dashboard-setup)
