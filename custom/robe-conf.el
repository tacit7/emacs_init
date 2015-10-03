(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'robe-mode)

(defun ugm/robe-start-api ()
	(interactive)
	(rvm-use "ruby-2.1.0" "api-socialcentiv-com")
	(ugm/hip-console)
	(robe-start))
