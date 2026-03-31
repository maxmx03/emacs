;;; early-init.el -*- lexical-binding: t; -*

(setq gc-cons-threshold (* 1024 1024 128)
      gc-cons-percentage 1.0)

(add-hook 'emacs-startup-hook (lambda ()
                                (setq gc-cons-threshold (* 1024 1024 2) ;; 2mb
                                      gc-cons-percentage 0.2)))

(setq read-process-output-max (* 1024 1024))

(setq menu-bar-mode nil)         ;; Disable the menu bar
(setq tool-bar-mode nil)         ;; Disable the tool bar
(push '(vertical-scroll-bars) default-frame-alist) ;; Disable the scroll 

(setq default-frame-alist '((background-color . "#161616")))
