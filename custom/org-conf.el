(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-directory "~/repo/org-mode")
(setq org-log-done 'time) ; timestamp for Todos when done



(setq org-todo-keywords
            '((sequence "TODO(t)"  "BLOCKED BY" "BLOCKING TO"  "|" "DONE(d)")
	       (sequence "Uriel"  "TJ" "JR(j)" "Conor(c)" "Ryan (r)" "Aaron (a)" "Kevin(k)" "Dave (d)" "Dave (h)" "|" "DONE(d)")
	      	(sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED(f)")
			(sequence "|" "CANCELED(c)")))


(smartparens-mode 0)
(setq org-startup-indented t)
(auto-fill-mode 1)
(setq org-agenda-files (list "~/repo/org-mode/"))
(setq org-src-fontify-natively t); make code blocks pretty
(setq  org-hide-leading-stars t)
; Some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ruby . t)
   (octave . t)
   ))
(setq-default fill-column 80)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; Set to the location of your Org files on your local system
(setq org-directory "~/repo/org-mode/")
