(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-directory "~/repo/org-mode")
(setq org-log-done 'time) ; timestamp for Todos when done
(org-display-inline-images t t)
(eval-after-load "org"
  '(require 'ox-md nil t))

(setq org-ellipsis " ▾")
(setq org-todo-keywords
      '((sequence "TODO(t)"  "BLOCKED BY" "BLOCKING TO"  "|" "DONE(d)")
	(sequence "Sprint" "Delayed" "|" "Done")
	(sequence "Open" "In Progress" "Code Review" "Resloved [QA Ready]" "QA Complete" "Closed")
	(sequence "Uriel"  "TJ" "Tiffany" "JR(j)" "Conor(c)" "Ryan (r)" "Rohan" "Aaron (a)" "Kevin(k)" "Dave (d)" "David (h)" "|" "DONE(d)")))

(setq org-export-publishing-directory "./exports")
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
   (js . t)
   (octave . t)
   ))
(setq-default fill-column 80)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; Set to the location of your Org files on your local system
(setq org-directory "~/repo/org-mode/")
(setq org-export-with-sub-superscripts nil)


(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(setq current-sprint "sprint020219")

(defun tag-with-sprint ()
  (interactive)
  (end-of-line)
  (insert (concat "  :" current-sprint ":"))
  (org-set-tags-command t))

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
    (tag-with-sprint)
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

(require 'dash)

(defun tacit7/is-directory-p (path)
 (nth 0 (file-attributes path)))

(defun tacit7/ls-directories (path)
  (let* ((exclude-dot-dirs-regex "^\\([^.]\\|\\.[^.]\\|\\.\\..\\...\\)")
	 (files-and-dirs (directory-files path :show-full-path exclude-dot-dirs-regex))
	 (dirs ((-select 'tacit7/is-directory-p files-and-dirs))))
    dirs))

(defun ugm/go-to-notes ()
  (find-file "/Users/umaldonado/repo/org-mode"))


;; ====================
;; insert date and time

(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun ugm/insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(defun ugm/insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )
(defalias 'ugm/insert-timestamp 'ugm/insert-current-time)

(defun ugm/org-insert-code-source (lang)
	(interactive "sLanguage: ")
	(insert "#+BEGIN_SRC ")
	(insert lang)
	(insert " \n")
	(insert "#+END_SRC "))
(global-set-key "\C-x\C-d" 'insert-current-date-time)
(global-set-key "\C-x\C-t" 'insert-current-time)
;; (defvar tacit7/journal-entry-time (* 30 60))
;; (defun tacit7/reminder-journal-entry ()
;;   "Remind me to enter in the jouRnal what ive done in the past thirty minutes"

;;   (run-at-time nil 1800 (org-journal-new-entry nil)) )
;;;
