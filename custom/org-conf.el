(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-directory "~/repo/org-mode")
(setq org-log-done 'time) ; timestamp for Todos when done

(eval-after-load "org"
  '(require 'ox-md nil t))

(defvar current-sprint "sprint011915")

(defun tag-with-sprint ()
  (interactive)
  (end-of-line)
  (insert (concat "            :" current-sprint ":"))
  (org-set-tags-commmand))

(setq org-todo-keywords
      '((sequence "TODO(t)"  "BLOCKED BY" "BLOCKING TO"  "|" "DONE(d)")
	(sequence "Sprint" "Delayed" "|" "Done")
	(sequence "Open" "In Progress" "Code Review" "Resloved [QA Ready]" "QA Complete" "Closed")
	(sequence "Uriel"  "TJ" "Tiffany" "JR(j)" "Conor(c)" "Ryan (r)" "Rohan" "Aaron (a)" "Kevin(k)" "Dave (d)" "Dave (h)" "|" "DONE(d)")))

(setq org-export-publishing-directory "./exports")
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
(setq org-export-with-sub-superscripts nil)






(defun phab-ticket-link (ticket-number)
  "Create an Org-Todo with a link to the ticket on code review."
  (let* ((url (concat "https://codereview.geoforce.net/T" ticket-number)))
    (tacit7/org-link url ticket-number)))

(defun phab-diff-link (diff-number)
  "Create a link to the diff on code review."
  (let* ((url (concat "https://codereview.geoforce.net/D" diff-number)))
    (tacit7/org-link url (concat "D" diff-number))))

(defun phab-add-diff-link (diff-number)
  "Add diff link to code review."
  (interactive "sDiff Number:")
  (insert (phab-diff-link diff-number)))

(defun phab-add-ticket-todo (ticket-number)
  (interactive "sTicket Number:")
  (let* (
	 (org-link (phab-ticket-link ticket-number))
	 (org-todo-line (concat "* Uriel " org-link ))
	 )
    (insert org-todo-line)
    (bookmark-set (concat "T" ticket-number))
    (insert "\n")
    (insert "Diff: \n")
    (insert "Files: \n")))

(defun set-mark-t ()
  (interactive)
  (bookmark-set "T234"))
(defun go-to-ticket ()
  "If youre at a word of form Tnumber, go to the ticket section."
  (interactive)
  (bookmark-jump (thing-at-point 'word)))


(defun tacit7/insert-file-name ()
  (interactive)
  (let* (
	 (project-file (projectile-completing-read "Find file: "
						   (projectile-current-project-files)))
	 (full-path-file (expand-file-name project-file (projectile-project-root)))
	 (file-name (nth 0
			 (last
			  (split-string full-path-file "/"))))
	 
	 (org-link (tacit7/org-link full-path-file file-name)))
    (insert org-link)))

(defun commit-at-point ()
  (interactive)
  (magit-show-commit (thing-at-point 'word)))

(defun tacit7/org-link (file desc)
  (concat "[[" file "][" desc "]]"))

(setq org-agenda-span 'month)


;;; Phabbricator

(defvar uriel-phid "PHID-USER-nq6jtsavod5vy7tkgfga")

;; (defvar tacit7/journal-entry-time (* 30 60))
;; (defun tacit7/reminder-journal-entry ()
;;   "Remind me to enter in the jouRnal what ive done in the past thirty minutes"

;;   (run-at-time nil 1800 (org-journal-new-entry nil)) )
;;;
