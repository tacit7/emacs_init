;;; Config hs


;; hide/show  aka folds
(add-to-list 'hs-special-modes-alist
	     '(enh-ruby-mode
	       "\\(def\\|do\\|{\\)" "\\(end\\|end\\|}\\)" "#"
	       (lambda (arg) (ruby-end-of-block)) nil))
(add-hook 'enh-ruby-mode-hook #'hs-minor-mode)
;;;;
