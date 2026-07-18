;; -*- lexical-binding: t; -*-

;; Set gargabe collector
(setq gc-cons-threshold (* 1024 1024 128) ;; 128mb
      gc-cons-percentage 1.0) ;; Disable the dynamic percentage trigger

;; Runtime performance
(add-hook 'emacs-startup-hook (lambda ()
				(setq gc-cons-threshold (* 1024 1024 2)
				      gc-cons-percentage 0.2)))

;; Increase the amount of data wich Emacs reads from process
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Unset file-name-handler-alist
(defvar last-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'after-init-hook
	  (lambda ()
	    (setq file-name-handler-alist last-file-name-handler-alist)))


;; Fix white flash on startup
;; Don't do it when using daemon or terminal, because it messes up the background color.
(unless (or (daemonp) (not initial-window-system))
  (setq default-frame-alist '(
                              (foreground-color . "white")
                              (background-color . "#1F1F28"))))

;; Disable UI elements before UI initialization
(setq menu-bar-mode nil) ;; Disable the menu bar
(setq tool-bar-mode nil) ;; Disable the tool bar
(push '(vertical-scroll-bar) default-frame-alist) ;; Disable the scroll bar

(set-face-attribute 'default nil
                    :font "JetBrainsMono Nerd Font Mono" ;; Set your favorite type of font or download JetBrains Mono
                    :height 140
                    :weight 'medium)
;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono")) ;; Set your favorite font
(setq-default line-spacing 0.12)

(let ((init-el (expand-file-name "init.el" user-emacs-directory))
      (init-org (expand-file-name "init.org" user-emacs-directory)))
  (unless (file-exists-p init-el)
    (when (file-exists-p init-org)
      (require 'org)
      (org-babel-tangle-file init-org init-el)
      (message "Tangling %s to create missing %s" init-org init-el))))
