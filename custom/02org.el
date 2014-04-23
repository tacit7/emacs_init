(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-directory "~/Google\ Drive/org-mode")
(setq org-directory "~/Google\ Drive/org-mode/archive")
(setq org-log-done 'time) ; timestamp for Todos when done



(setq org-todo-keywords
            '((sequence "TODO(t)" "|" "DONE(d)")
	      	(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
			(sequence "|" "CANCELED(c)")))



(smartparens-mode 0)
(setq org-startup-indented t)
(auto-fill-mode 1)
(set-fill-column 80)
(setq org-agenda-files (list "~/Google Drive/org-mode/"))
(add-hook 'org-mode-hook 'turn-on-flyspell) ; turn on spell checking
(setq-default fill-column 80)

; Some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ruby . t)
   (octave . t)
   ))
