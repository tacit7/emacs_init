(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/yasnippet-snippets" )
 )

(add-hook 'yas-before-expand-snippet-hook
	  #'(lambda()
	      (when (evil-visual-state-p)
		(let ((p (point))
		      (m (mark)))
		  (evil-insert-state)
		  (goto-char p)
		  (set-mark m)))))
