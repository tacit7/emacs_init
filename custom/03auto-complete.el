 (require 'auto-complete-config)
 (require 'robe)
 (add-to-list 'ac-dictionary-directories
	           "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
 (ac-config-default)
 (setq ac-ignore-case nil)
 (add-to-list 'ac-modes 'enh-ruby-mode)
 (add-to-list 'ac-modes 'web-mode)
 (add-to-list 'robe-mode-hook 'ac-robe-setup)
