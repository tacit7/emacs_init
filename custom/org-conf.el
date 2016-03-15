(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-directory "~/uriel-repo/notes/")
(setq org-log-done 'time) ; timestamp for Todos when done
                                        ;(setq org-plantuml-jar-path "~/uriel-repo/emacs/scripts/plantuml.jar")
;(org-display-inline-images  t)
(eval-after-load "org"
  '(require 'ox-md nil t)) ; markdown

(setq org-confirm-babel-evaluate nil)
(setq org-fontify-whole-heading-line t)
(setq org-startup-with-inline-images t)

;; So we can clock tasks
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-into-drawer t);; Clock into drawer
(setq org-ellipsis " ▾")
(setq org-startup-indented t)
(auto-fill-mode 1)
(setq org-src-fontify-natively t); make code blocks pretty
(setq  org-hide-leading-stars t)
; Some initial langauges we want org-babel to support
(setq org-log-done t)
;; Set to the location of your Org files on your local system
(setq org-export-with-sub-superscripts nil)


;; (defun ugm/go-to-pull-request-number (pull-requset-id)
;; 	"Giver a number at point, go to the pull requset with numbet PULL-REQUEST-ID."

;; 		("https://github.com/SocialCentiv/api-socialcentiv-com/pull"))
(add-to-load-path "~/uriel-repo/emacs/org-bullets")
 (require 'org-bullets)
 (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))



(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ruby . t)
   (js . t)
   (plantuml . t)
   (octave . t)
   ))
;; (defun tag-with-sprint ()
;;   (interactive)
;;   (end-of-line)
;;   (insert (concat "  :" current-sprint ":"))
;;   (org-set-tags-command t))

(defun ugm/org-insert-checkbox ()
  "Insert an \"org-mode\" check box."
  (interactive)
  (insert "- [ ] "))

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

(global-set-key (kbd "C-x g") 'magit-status)


;;; Phabbricator


(defun tacit7/is-directory-p (path)
  (nth 0 (file-attributes path)))

(defun tacit7/ls-directories (path)
  (let* ((exclude-dot-dirs-regex "^\\([^.]\\|\\.[^.]\\|\\.\\..\\...\\)")
         (files-and-dirs (directory-files path :show-full-path exclude-dot-dirs-regex))
         (dirs ((-select 'tacit7/is-directory-p files-and-dirs))))
    dirs))

;; ====================
;; insert date and time

;; (defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
;;   "Format of date to insert with `insert-current-date-time' func
;; See help of `format-time-string' for possible replacements")

;; (defvar current-time-format "%a %H:%M:%S"
;;   "Format of date to insert with `insert-current-time' func.
;; Note the weekly scope of the command's precision.")

;; (defun ugm/insert-current-date-time ()
;;   "insert the current date and time into current buffer.
;; Uses `current-date-time-format' for the formatting the date/time."
;;        (interactive)
;;        (insert "==========\n")
;; ;       (insert (let () (comment-start)))
;;        (insert (format-time-string current-date-time-format (current-time)))
;;        (insert "\n")
;;        )

;; (defun ugm/insert-current-time ()
;;   "insert the current time (1-week scope) into the current buffer."
;;        (interactive)
;;        (insert (format-time-string current-time-format (current-time)))
;;        (insert "\n")
;;        )
;; (defalias 'ugm/insert-timestamp 'ugm/insert-current-time)
;; (setq org-agenda-custom-commands
;;       '(("gm" "Calendar" agenda ""
;;          ((org-agenda-ndays -60)
;;           (org-agenda-start-on-weekday 0)))))


;; (defun ugm/org-insert-code-source (lang)
;; 	(interactive "sLanguage: ")
;; 	(insert "#+BEGIN_SRC ")
;; 	(insert lang)
;; 	(insert " \n")
;; 	(insert "#+END_SRC "))

;; (defun ugm/org-insert-uml (project file-name)
;; 	(interactive "sProject: \nsName: ")
;; 	(insert "#+BEGIN_SRC plantuml :file ./img/" project  "/" file-name)
;; 	(insert " \n")
;; (insert "#+END_SRC "))
                                        ;http://ergoemacs.org/emacs/elisp_idioms_prompting_input.html
(defun ugm/he (task priority effort)
  "Insert a task."
  (interactive
   (list
    (read-string "Task Name: ")
    (completing-read "Priority: " '("A" "B" "C"))
    (completing-read "Effort: " '("0" "0:10" "0:20" "0:30" "1:00" "2:00" "4:00" "6:00" "8:00"))))
  (insert
   "* TODO [#"priority"] " task "\n"
   ":LOGBOOK:\n"
   ":END:\n"
   ":PROPERTIES:\n"
   ":Effort: " effort "\n"
   ":END:"))
(setq org-confirm-babel-evaluate nil)
(global-set-key "\C-x\C-d" 'insert-current-date-time)
(global-set-key "\C-x\C-t" 'insert-current-time)
                                        ;(add-to-list 'org-file-apps '(directory . emacs)); use emacs to open directries
;; (defvar tacit7/journal-entry-time (* 30 60))
;; (defun tacit7/reminder-journal-entry ()
;;   "Remind me to enter in the jouRnal what ive done in the past thirty minutes"

;;   (run-at-time nil 1800 (org-journal-new-entry nil)) )
;;;

(setq org-capture-templates
      '(("n"
         "Journal Entry"
         entry (file+datetree "~/uriel-repo/notes/1kb-journal.org")
         "* %<%I:%M CST> ")
        ("s"
         "Journal Entry - Subtask"
         entry (file+datetree "~/uriel-repo/notes/1kb-journal.org")
         "****** %<%I:%M CST> ")
        ("c"
         "Journal Entry in Current task"
         entry (file+datetree "~/uriel-repo/notes/1kb-journal.org")
         "%<%I:%M CST> ")))


(add-to-list 'org-structure-template-alist
             '("srb" "#+BEGIN_SRC ruby :result output :session strangler-console\n?\n#+END_SRC"))
