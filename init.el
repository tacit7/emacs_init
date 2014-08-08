(require 'cask "/usr/local/Cellar/cask/0.6.0/cask.el")
(cask-initialize)
(require 'pallet)
(add-to-list 'load-path "~/repo/emacs/")
(add-to-list 'load-path "~/repo/emacs/powerline/")
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'exec-path "/usr/local/Cellar/aspell/0.60.6.1/bin")

(load "01ruby.el")
;(load "02org.el")
(load "03auto-complete.el")
(load "05robe.el")
(load "07yasnippet.el")
(load "08evil.el")
(load "09projectile.el")
(load "10smartparens")
(load "11robe.el")
(load "ido-config.el")
(load "~/repo/emacs/evil-org-mode/evil-org.el")
(load "~/repo/emacs/powerline/powerline.el")
(load "00common-setup.el")

(require 'powerline)
(powerline-default-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "4226515beb6ca80245ca8e269386e16095a56122029190b2416f7607797c12c0" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
