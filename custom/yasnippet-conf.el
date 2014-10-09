(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/yasnippet-snippets" )
      )
(add-hook 'web-mode-hook #'(lambda () (set (make-local-variable 'yas--extra-modes) 'html-mode)))
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))

(add-hook 'web-mode-hook #'(lambda () (set (make-local-variable 'yas--extra-modes) 'js2-mode)))
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'javascript-mode)))
(add-hook 'yas-before-expand-snippet-hook
	  #'(lambda()
	      (when (evil-visual-state-p)
		(let ((p (point))
		      (m (mark)))
		  (evil-insert-state)
		  (goto-char p)
		  (set-mark m)))))


(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(add-hook 'web-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))